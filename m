From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 02/23] drm/amdgpu: add kiq into compiling
Date: Tue, 20 Dec 2016 03:48:54 +0000
Message-ID: <CAHbf0-EqT1YHuxButQkfb8s3mGT4WjVdcjCWMFetiqwjEME8pA@mail.gmail.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
 <1481991405-30422-3-git-send-email-Xiangliang.Yu@amd.com>
 <CY4PR12MB170115ECFEEDEE2B92071FE7EB9E0@CY4PR12MB1701.namprd12.prod.outlook.com>
 <BY2PR12MB0054C15BB4903E12764EABF684910@BY2PR12MB0054.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1072782104=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR12MB0054C15BB4903E12764EABF684910-K//h7OWB4q7GdVlgMuSljQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1072782104==
Content-Type: multipart/alternative; boundary=94eb2c0864fce7af9005440eeac6

--94eb2c0864fce7af9005440eeac6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'd be curious to know what AI stands for in this context

On Mon, 19 Dec 2016 at 07:28 Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org> wrote:

> Sorry, NAK for the KIQ implement patches.
>
> KIQ is just another compute queue, and each  generation of compute queue
> initialization is different, so there is no need of a amdgpu_kiq.c file t=
o
> cover the function of kiq,
>
> Kiq is good enough to be in each gfx_x_x.c file .e.g :
> KIQ  for VI is in gfx_v8_0.c
> And KIQ for AI is in gfx_v9_0.c
>
> Most important is that the "queue_init" routine of above two chips on KIQ
> is different (MQD descriptor as well as registers need programing ... ),
> please just align with the previous patch style in amd-sriov-4.6 for KIQ
> part
>
> BR Monk
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Yu, Xiangliang
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: Sunday, December 18, 2016 9:47 AM
> =E6=94=B6=E4=BB=B6=E4=BA=BA: dl.SRDC_SW_GPUVirtualization
> =E4=B8=BB=E9=A2=98: FW: [PATCH 02/23] drm/amdgpu: add kiq into compiling
>
>
>
> -----Original Message-----
> From: Xiangliang Yu [mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org]
> Sent: Sunday, December 18, 2016 12:16 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dl.SRDC_SW_GPUVirtualization <
> dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org>
> Cc: Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH 02/23] drm/amdgpu: add kiq into compiling
>
> Add support KIQ in Makefile to make it into module.
>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> b/drivers/gpu/drm/amd/amdgpu/Makefile
> index dd0b6db..635ff94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -30,7 +30,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
>         atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>         amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
>         amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> -       amdgpu_gtt_mgr.o amdgpu_vram_mgr.o
> +       amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_kiq.o
>
>  # add asic specific block
>  amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+=3D cik.o cik_ih.o kv_smc.o kv_dpm.o \
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--94eb2c0864fce7af9005440eeac6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;d be curious to know what AI stands for in this cont=
ext<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, 19 Dec 2016 =
at 07:28 Liu, Monk &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu-5C7GfCeVMHo@public.gmane.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Sorry, NAK for the =
KIQ implement patches.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
KIQ is just another compute queue, and each=C2=A0 generation of compute que=
ue initialization is different, so there is no need of a amdgpu_kiq.c file =
to cover the function of kiq,<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Kiq is good enough to be in each gfx_x_x.c file .e.g :<br class=3D"gmail_ms=
g">
KIQ=C2=A0 for VI is in gfx_v8_0.c<br class=3D"gmail_msg">
And KIQ for AI is in gfx_v9_0.c<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Most important is that the &quot;queue_init&quot; routine of above two chip=
s on KIQ is different (MQD descriptor as well as registers need programing =
... ), please just align with the previous patch style in amd-sriov-4.6 for=
 KIQ part<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
BR Monk<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----<br class=3D"gmail_msg">
=E5=8F=91=E4=BB=B6=E4=BA=BA: Yu, Xiangliang<br class=3D"gmail_msg">
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: Sunday, December 18, 2016 9:47 AM<br =
class=3D"gmail_msg">
=E6=94=B6=E4=BB=B6=E4=BA=BA: dl.SRDC_SW_GPUVirtualization<br class=3D"gmail=
_msg">
=E4=B8=BB=E9=A2=98: FW: [PATCH 02/23] drm/amdgpu: add kiq into compiling<br=
 class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-----Original Message-----<br class=3D"gmail_msg">
From: Xiangliang Yu [mailto:<a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org" class=
=3D"gmail_msg" target=3D"_blank">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>]<br class=3D"gma=
il_msg">
Sent: Sunday, December 18, 2016 12:16 AM<br class=3D"gmail_msg">
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" ta=
rget=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; dl.SRDC_SW_GPUVirtualiza=
tion &lt;<a href=3D"mailto:dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org" class=3D"g=
mail_msg" target=3D"_blank">dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org</a>&gt;<br=
 class=3D"gmail_msg">
Cc: Yu, Xiangliang &lt;<a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org" class=3D"gm=
ail_msg" target=3D"_blank">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=3D"gmail_=
msg">
Subject: [PATCH 02/23] drm/amdgpu: add kiq into compiling<br class=3D"gmail=
_msg">
<br class=3D"gmail_msg">
Add support KIQ in Makefile to make it into module.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Signed-off-by: Xiangliang Yu &lt;<a href=3D"mailto:Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org" c=
lass=3D"gmail_msg" target=3D"_blank">Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br class=
=3D"gmail_msg">
---<br class=3D"gmail_msg">
=C2=A0drivers/gpu/drm/amd/amdgpu/Makefile | 2 +-<br class=3D"gmail_msg">
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile<br class=3D"gmail_msg">
index dd0b6db..635ff94 100644<br class=3D"gmail_msg">
--- a/drivers/gpu/drm/amd/amdgpu/Makefile<br class=3D"gmail_msg">
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br class=3D"gmail_msg">
@@ -30,7 +30,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \<br class=3D"=
gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atombios_encoders.o amdgpu_sa.o atombios_i2c.o =
\<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_p=
ll.o \<br class=3D"gmail_msg">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o am=
dgpu_sync.o \<br class=3D"gmail_msg">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gtt_mgr.o amdgpu_vram_mgr.o<br class=3D"=
gmail_msg">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_kiq.o=
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
=C2=A0# add asic specific block<br class=3D"gmail_msg">
=C2=A0amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+=3D cik.o cik_ih.o kv_smc.o kv_dpm.o =
\<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
2.7.4<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
_______________________________________________<br class=3D"gmail_msg">
amd-gfx mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" class=3D"gmail_msg" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br class=3D"gmail_msg">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx</a><br class=3D"gmail_msg">
</blockquote></div></div>

--94eb2c0864fce7af9005440eeac6--

--===============1072782104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1072782104==--

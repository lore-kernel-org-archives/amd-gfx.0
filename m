From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: Fix KASAN user after free on
 driver unload.
Date: Thu, 15 Mar 2018 09:36:57 +0000
Message-ID: <CY4PR12MB16870B976E509F1D36F56480FBD00@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1521050869-29589-1-git-send-email-andrey.grodzovsky@amd.com>
 <1521050869-29589-2-git-send-email-andrey.grodzovsky@amd.com>,
 <992da07d-1f19-3a1d-c065-10824871f756@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0450427012=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <992da07d-1f19-3a1d-c065-10824871f756-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0450427012==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16870B976E509F1D36F56480FBD00CY4PR12MB1687namp_"

--_000_CY4PR12MB16870B976E509F1D36F56480FBD00CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Apply this patch with Christian's suggestions.


Thanks.


Best Regards

Rex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, March 15, 2018 2:21 AM
To: Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex; Koenig, Christian
Subject: Re: [PATCH 2/2] drm/amd/powerplay: Fix KASAN user after free on dr=
iver unload.

Am 14.03.2018 um 19:07 schrieb Andrey Grodzovsky:
> Reusing local handle to initialize BO without resetting it to
> NULL is wrong since it causes amdgpu_bo_create_reserved to skip
> new BO creation and just reuse the given pointer for pinning.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c     |  7 ++-----
>   drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 16 +++++--------=
---
>   2 files changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/rv_smumgr.c
> index e2ee23a..65c6ca7 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
> @@ -327,7 +327,6 @@ static int rv_start_smu(struct pp_hwmgr *hwmgr)
>
>   static int rv_smu_init(struct pp_hwmgr *hwmgr)
>   {
> -     struct amdgpu_bo *handle =3D NULL;
>        struct rv_smumgr *priv;
>        uint64_t mc_addr;
>        void *kaddr =3D NULL;
> @@ -345,7 +344,7 @@ static int rv_smu_init(struct pp_hwmgr *hwmgr)
>                        sizeof(Watermarks_t),
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM,
> -                     &handle,
> +                     &priv->smu_tables.entry[WMTABLE].handle,
>                        &mc_addr,
>                        &kaddr);
>
> @@ -357,14 +356,13 @@ static int rv_smu_init(struct pp_hwmgr *hwmgr)
>        priv->smu_tables.entry[WMTABLE].table_id =3D TABLE_WATERMARKS;
>        priv->smu_tables.entry[WMTABLE].mc_addr =3D mc_addr;
>        priv->smu_tables.entry[WMTABLE].table =3D kaddr;
> -     priv->smu_tables.entry[WMTABLE].handle =3D handle;
>
>        /* allocate space for watermarks table */
>        r =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->adev,
>                        sizeof(DpmClocks_t),
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM,
> -                     &handle,
> +                     &priv->smu_tables.entry[CLOCKTABLE].handle,
>                        &mc_addr,
>                        &kaddr);
>
> @@ -380,7 +378,6 @@ static int rv_smu_init(struct pp_hwmgr *hwmgr)
>        priv->smu_tables.entry[CLOCKTABLE].table_id =3D TABLE_DPMCLOCKS;
>        priv->smu_tables.entry[CLOCKTABLE].mc_addr =3D mc_addr;
>        priv->smu_tables.entry[CLOCKTABLE].table =3D kaddr;
> -     priv->smu_tables.entry[CLOCKTABLE].handle =3D handle;
>
>        return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drive=
rs/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> index 15e1afa..c8b326e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
> @@ -377,7 +377,6 @@ static int vega10_verify_smc_interface(struct pp_hwmg=
r *hwmgr)
>
>   static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>   {
> -     struct amdgpu_bo *handle =3D NULL;
>        struct vega10_smumgr *priv;
>        uint64_t mc_addr;
>        void *kaddr =3D NULL;
> @@ -403,7 +402,7 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>                        sizeof(PPTable_t),
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM,
> -                     &handle,
> +                     &priv->smu_tables.entry[PPTABLE].handle,
>                        &mc_addr,
>                        &kaddr);
>
> @@ -415,14 +414,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>        priv->smu_tables.entry[PPTABLE].table_id =3D TABLE_PPTABLE;
>        priv->smu_tables.entry[PPTABLE].mc_addr =3D mc_addr;
>        priv->smu_tables.entry[PPTABLE].table =3D kaddr;
> -     priv->smu_tables.entry[PPTABLE].handle =3D handle;
>
>        /* allocate space for watermarks table */
>        ret =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->ade=
v,
>                        sizeof(Watermarks_t),
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM,
> -                     &handle,
> +                     &priv->smu_tables.entry[WMTABLE].handle,
>                        &mc_addr,
>                        &kaddr);
>
> @@ -434,14 +432,13 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>        priv->smu_tables.entry[WMTABLE].table_id =3D TABLE_WATERMARKS;
>        priv->smu_tables.entry[WMTABLE].mc_addr =3D mc_addr;
>        priv->smu_tables.entry[WMTABLE].table =3D kaddr;
> -     priv->smu_tables.entry[WMTABLE].handle =3D handle;
>
>        /* allocate space for AVFS table */
>        ret =3D amdgpu_bo_create_kernel((struct amdgpu_device *)hwmgr->ade=
v,
>                        sizeof(AvfsTable_t),
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM,
> -                     &handle,
> +                     &priv->smu_tables.entry[AVFSTABLE].handle,
>                        &mc_addr,
>                        &kaddr);
>
> @@ -453,7 +450,6 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>        priv->smu_tables.entry[AVFSTABLE].table_id =3D TABLE_AVFS;
>        priv->smu_tables.entry[AVFSTABLE].mc_addr =3D mc_addr;
>        priv->smu_tables.entry[AVFSTABLE].table =3D kaddr;
> -     priv->smu_tables.entry[AVFSTABLE].handle =3D handle;
>
>        tools_size =3D 0x19000;
>        if (tools_size) {
> @@ -461,7 +457,7 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>                                tools_size,
>                                PAGE_SIZE,
>                                AMDGPU_GEM_DOMAIN_VRAM,
> -                             &handle,
> +                             &priv->smu_tables.entry[TOOLSTABLE].handle,
>                                &mc_addr,
>                                &kaddr);

I think it would be better to specify mc_addr and kaddr directly as well.

Christian.

>                if (ret)
> @@ -471,7 +467,6 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>                priv->smu_tables.entry[TOOLSTABLE].table_id =3D TABLE_PMST=
ATUSLOG;
>                priv->smu_tables.entry[TOOLSTABLE].mc_addr =3D mc_addr;
>                priv->smu_tables.entry[TOOLSTABLE].table =3D kaddr;
> -             priv->smu_tables.entry[TOOLSTABLE].handle =3D handle;
>        }
>
>        /* allocate space for AVFS Fuse table */
> @@ -479,7 +474,7 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>                        sizeof(AvfsFuseOverride_t),
>                        PAGE_SIZE,
>                        AMDGPU_GEM_DOMAIN_VRAM,
> -                     &handle,
> +                     &priv->smu_tables.entry[AVFSFUSETABLE].handle,
>                        &mc_addr,
>                        &kaddr);
>        if (ret)
> @@ -490,7 +485,6 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>        priv->smu_tables.entry[AVFSFUSETABLE].table_id =3D TABLE_AVFS_FUSE=
_OVERRIDE;
>        priv->smu_tables.entry[AVFSFUSETABLE].mc_addr =3D mc_addr;
>        priv->smu_tables.entry[AVFSFUSETABLE].table =3D kaddr;
> -     priv->smu_tables.entry[AVFSFUSETABLE].handle =3D handle;
>
>        return 0;
>


--_000_CY4PR12MB16870B976E509F1D36F56480FBD00CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Apply this patch with Christian's=
 suggestions.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &l=
t;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 15, 2018 2:21 AM<br>
<b>To:</b> Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex; Koenig, Christian<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/powerplay: Fix KASAN user after fre=
e on driver unload.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 14.03.2018 um 19:07 schrieb Andrey Grodzovsky:<=
br>
&gt; Reusing local handle to initialize BO without resetting it to<br>
&gt; NULL is wrong since it causes amdgpu_bo_create_reserved to skip<br>
&gt; new BO creation and just reuse the given pointer for pinning.<br>
&gt;<br>
&gt; Signed-off-by: Andrey Grodzovsky &lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 7 &#43;&#43;-----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 16 =
&#43;&#43;&#43;&#43;&#43;-----------<br>
&gt;&nbsp;&nbsp; 2 files changed, 7 insertions(&#43;), 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c<br>
&gt; index e2ee23a..65c6ca7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c<br>
&gt; @@ -327,7 &#43;327,6 @@ static int rv_start_smu(struct pp_hwmgr *hwmgr=
)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int rv_smu_init(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *handle =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rv_smumgr *priv;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *kaddr =3D NULL;<br>
&gt; @@ -345,7 &#43;344,7 @@ static int rv_smu_init(struct pp_hwmgr *hwmgr)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
Watermarks_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_t=
ables.entry[WMTABLE].handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc=
_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ka=
ddr);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -357,14 &#43;356,13 @@ static int rv_smu_init(struct pp_hwmgr *hwmg=
r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WM=
TABLE].table_id =3D TABLE_WATERMARKS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WM=
TABLE].mc_addr =3D mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WM=
TABLE].table =3D kaddr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WMTABLE].handle =
=3D handle;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate space for waterm=
arks table */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kerne=
l((struct amdgpu_device *)hwmgr-&gt;adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
DpmClocks_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_t=
ables.entry[CLOCKTABLE].handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc=
_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ka=
ddr);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -380,7 &#43;378,6 @@ static int rv_smu_init(struct pp_hwmgr *hwmgr)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[CL=
OCKTABLE].table_id =3D TABLE_DPMCLOCKS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[CL=
OCKTABLE].mc_addr =3D mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[CL=
OCKTABLE].table =3D kaddr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[CLOCKTABLE].handle=
 =3D handle;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/dr=
ivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
&gt; index 15e1afa..c8b326e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c=
<br>
&gt; @@ -377,7 &#43;377,6 @@ static int vega10_verify_smc_interface(struct =
pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int vega10_smu_init(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *handle =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_smumgr *priv;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *kaddr =3D NULL;<br>
&gt; @@ -403,7 &#43;402,7 @@ static int vega10_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
PPTable_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_t=
ables.entry[PPTABLE].handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc=
_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ka=
ddr);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -415,14 &#43;414,13 @@ static int vega10_smu_init(struct pp_hwmgr *=
hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[PP=
TABLE].table_id =3D TABLE_PPTABLE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[PP=
TABLE].mc_addr =3D mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[PP=
TABLE].table =3D kaddr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[PPTABLE].handle =
=3D handle;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate space for waterm=
arks table */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_ker=
nel((struct amdgpu_device *)hwmgr-&gt;adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
Watermarks_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_t=
ables.entry[WMTABLE].handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc=
_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ka=
ddr);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -434,14 &#43;432,13 @@ static int vega10_smu_init(struct pp_hwmgr *=
hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WM=
TABLE].table_id =3D TABLE_WATERMARKS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WM=
TABLE].mc_addr =3D mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WM=
TABLE].table =3D kaddr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[WMTABLE].handle =
=3D handle;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate space for AVFS t=
able */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_ker=
nel((struct amdgpu_device *)hwmgr-&gt;adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
AvfsTable_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_t=
ables.entry[AVFSTABLE].handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc=
_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ka=
ddr);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -453,7 &#43;450,6 @@ static int vega10_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AV=
FSTABLE].table_id =3D TABLE_AVFS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AV=
FSTABLE].mc_addr =3D mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AV=
FSTABLE].table =3D kaddr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AVFSTABLE].handle =
=3D handle;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tools_size =3D 0x19000;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tools_size) {<br>
&gt; @@ -461,7 &#43;457,7 @@ static int vega10_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tools_size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SIZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_tables.entry[TOOLSTABLE].han=
dle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;kaddr);<br>
<br>
I think it would be better to specify mc_addr and kaddr directly as well.<b=
r>
<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; @@ -471,7 &#43;467,6 @@ static int vega10_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[TOOLSTABLE].table_id =3D TABL=
E_PMSTATUSLOG;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[TOOLSTABLE].mc_addr =3D mc_ad=
dr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[TOOLSTABLE].table =3D kaddr;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; priv-&gt;smu_tables.entry[TOOLSTABLE].handle =3D handle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate space for AVFS F=
use table */<br>
&gt; @@ -479,7 &#43;474,7 @@ static int vega10_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(=
AvfsFuseOverride_t),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;priv-&gt;smu_t=
ables.entry[AVFSFUSETABLE].handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mc=
_addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ka=
ddr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; @@ -490,7 &#43;485,6 @@ static int vega10_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AV=
FSFUSETABLE].table_id =3D TABLE_AVFS_FUSE_OVERRIDE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AV=
FSFUSETABLE].mc_addr =3D mc_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AV=
FSFUSETABLE].table =3D kaddr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; priv-&gt;smu_tables.entry[AVFSFUSETABLE].han=
dle =3D handle;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16870B976E509F1D36F56480FBD00CY4PR12MB1687namp_--

--===============0450427012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0450427012==--

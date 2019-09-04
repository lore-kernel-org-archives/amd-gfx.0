From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: replace smu->table_count with
 SMU_TABLE_COUNT in smu
Date: Wed, 4 Sep 2019 02:11:47 +0000
Message-ID: <MN2PR12MB3296F888862316BBEB874AC2A2B80@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190903081702.24937-1-kevin1.wang@amd.com>,
 <MN2PR12MB3344CB5D45A7FE830BDC4E34E4B80@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1783607258=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344CB5D45A7FE830BDC4E34E4B80-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============1783607258==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296F888862316BBEB874AC2A2B80MN2PR12MB3296namp_"

--_000_MN2PR12MB3296F888862316BBEB874AC2A2B80MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, September 4, 2019 9:17 AM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: replace smu->table_count with SMU_T=
ABLE_COUNT in smu

Please drop the table_count member from the smu_table structure as it's tot=
ally unused.
With that fixed, the patch is reviewed-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>

[Kevin]:
sure, it should be removed in this patch.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
> Wang, Kevin(Yang)
> Sent: 2019=1B$BG/=1B(B9=1B$B7n=1B(B3=1B$BF|=1B(B 16:17
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
> Cc: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH] drm/amd/powerplay: replace smu->table_count with
> SMU_TABLE_COUNT in smu
>
> fix bellow patch issue:
> drm/amd/powerplay: introduce smu table id type to handle the smu table
> for each asic
> ----
> "This patch introduces new smu table type, it's to handle the  different =
smu
> table  defines for each asic with the same smu ip."
>
> before:
> use smu->table_count to represent the actual table count in smc firmware
> use actual table count to check smu function parameter about smu table
> after:
> use logic table count "SMU_TABLE_COUNT" to check function parameter
> because table id already mapped in smu driver, and smu function will use
> logic table id not actual table id to check func parameter.
>
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 13 ++++---------
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |  1 -
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c   |  1 -
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c   |  1 -
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c    |  5 ++---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c   |  1 -
>  6 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 6f435d60fe86..c71a82a6a785 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -462,7 +462,7 @@ int smu_update_table(struct smu_context *smu,
> enum smu_table_id table_index, int
>        int ret =3D 0;
>        int table_id =3D smu_table_get_index(smu, table_index);
>
> -     if (!table_data || table_id >=3D smu_table->table_count || table_id=
 < 0)
> +     if (!table_data || table_id >=3D SMU_TABLE_COUNT || table_id < 0)
>                return -EINVAL;
>
>        table =3D &smu_table->tables[table_index]; @@ -940,14 +940,10 @@
> static int smu_init_fb_allocations(struct smu_context *smu)
>        struct amdgpu_device *adev =3D smu->adev;
>        struct smu_table_context *smu_table =3D &smu->smu_table;
>        struct smu_table *tables =3D smu_table->tables;
> -     uint32_t table_count =3D smu_table->table_count;
>        uint32_t i =3D 0;
>        int32_t ret =3D 0;
>
> -     if (table_count <=3D 0)
> -             return -EINVAL;
> -
> -     for (i =3D 0 ; i < table_count; i++) {
> +     for (i =3D 0; i < SMU_TABLE_COUNT; i++) {
>                if (tables[i].size =3D=3D 0)
>                        continue;
>                ret =3D amdgpu_bo_create_kernel(adev,
> @@ -978,13 +974,12 @@ static int smu_fini_fb_allocations(struct
> smu_context *smu)  {
>        struct smu_table_context *smu_table =3D &smu->smu_table;
>        struct smu_table *tables =3D smu_table->tables;
> -     uint32_t table_count =3D smu_table->table_count;
>        uint32_t i =3D 0;
>
> -     if (table_count =3D=3D 0 || tables =3D=3D NULL)
> +     if (!tables)
>                return 0;
>
> -     for (i =3D 0 ; i < table_count; i++) {
> +     for (i =3D 0; i < SMU_TABLE_COUNT; i++) {
>                if (tables[i].size =3D=3D 0)
>                        continue;
>                amdgpu_bo_free_kernel(&tables[i].bo,
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index f1f072012fac..6e8eb0f94c8b 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -1934,5 +1934,4 @@ void arcturus_set_ppt_funcs(struct smu_context
> *smu)
>        struct smu_table_context *smu_table =3D &smu->smu_table;
>
>        smu->ppt_funcs =3D &arcturus_ppt_funcs;
> -     smu_table->table_count =3D TABLE_COUNT;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 744b7501c34d..e3add8b59291 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1633,5 +1633,4 @@ void navi10_set_ppt_funcs(struct smu_context
> *smu)
>        struct smu_table_context *smu_table =3D &smu->smu_table;
>
>        smu->ppt_funcs =3D &navi10_ppt_funcs;
> -     smu_table->table_count =3D TABLE_COUNT;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index de43159564a5..2b953f7431b6 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -169,5 +169,4 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
>
>        smu->ppt_funcs =3D &renoir_ppt_funcs;
>        smu->smc_if_version =3D SMU12_DRIVER_IF_VERSION;
> -     smu_table->table_count =3D TABLE_COUNT;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index deca9f85764c..3709e4d77338 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -439,7 +439,7 @@ static int smu_v11_0_init_smc_tables(struct
> smu_context *smu)
>        struct smu_table *tables =3D NULL;
>        int ret =3D 0;
>
> -     if (smu_table->tables || smu_table->table_count =3D=3D 0)
> +     if (smu_table->tables)
>                return -EINVAL;
>
>        tables =3D kcalloc(SMU_TABLE_COUNT, sizeof(struct smu_table), @@ -
> 465,13 +465,12 @@ static int smu_v11_0_fini_smc_tables(struct
> smu_context *smu)
>        struct smu_table_context *smu_table =3D &smu->smu_table;
>        int ret =3D 0;
>
> -     if (!smu_table->tables || smu_table->table_count =3D=3D 0)
> +     if (!smu_table->tables)
>                return -EINVAL;
>
>        kfree(smu_table->tables);
>        kfree(smu_table->metrics_table);
>        smu_table->tables =3D NULL;
> -     smu_table->table_count =3D 0;
>        smu_table->metrics_table =3D NULL;
>        smu_table->metrics_time =3D 0;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 899bf96b23e1..68548ba9b6ea 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3189,5 +3189,4 @@ void vega20_set_ppt_funcs(struct smu_context
> *smu)
>        struct smu_table_context *smu_table =3D &smu->smu_table;
>
>        smu->ppt_funcs =3D &vega20_ppt_funcs;
> -     smu_table->table_count =3D TABLE_COUNT;
>  }
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296F888862316BBEB874AC2A2B80MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 4, 2019 9:17 AM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huan=
g@amd.com&gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: replace smu-&gt;table_count =
with SMU_TABLE_COUNT in smu</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Please drop the table_count member from the smu_ta=
ble structure as it's totally unused.<br>
With that fixed, the patch is reviewed-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&=
gt;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[Kevin]:</div>
<div class=3D"PlainText">sure, it should be removed in this patch.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of<br>
&gt; Wang, Kevin(Yang)<br>
&gt; Sent: 2019=1B$BG/=1B(B9=1B$B7n=1B(B3=1B$BF|=1B(B 16:17<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt=
;<br>
&gt; Cc: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH] drm/amd/powerplay: replace smu-&gt;table_count with<b=
r>
&gt; SMU_TABLE_COUNT in smu<br>
&gt; <br>
&gt; fix bellow patch issue:<br>
&gt; drm/amd/powerplay: introduce smu table id type to handle the smu table=
<br>
&gt; for each asic<br>
&gt; ----<br>
&gt; &quot;This patch introduces new smu table type, it's to handle the&nbs=
p; different smu<br>
&gt; table&nbsp; defines for each asic with the same smu ip.&quot;<br>
&gt; <br>
&gt; before:<br>
&gt; use smu-&gt;table_count to represent the actual table count in smc fir=
mware<br>
&gt; use actual table count to check smu function parameter about smu table=
<br>
&gt; after:<br>
&gt; use logic table count &quot;SMU_TABLE_COUNT&quot; to check function pa=
rameter<br>
&gt; because table id already mapped in smu driver, and smu function will u=
se<br>
&gt; logic table id not actual table id to check func parameter.<br>
&gt; <br>
&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp; | 13 &#43=
;&#43;&#43;&#43;---------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |&nbsp; 1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp; |&nbsp; 1=
 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp; |&nbsp; 1=
 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp; |&nb=
sp; 5 &#43;&#43;---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp; |&nbsp; 1=
 -<br>
&gt;&nbsp; 6 files changed, 6 insertions(&#43;), 16 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index 6f435d60fe86..c71a82a6a785 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -462,7 &#43;462,7 @@ int smu_update_table(struct smu_context *smu,<=
br>
&gt; enum smu_table_id table_index, int<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_id =3D smu_table_g=
et_index(smu, table_index);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!table_data || table_id &gt;=3D smu_tabl=
e-&gt;table_count || table_id &lt; 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!table_data || table_id &gt;=3D SMU_=
TABLE_COUNT || table_id &lt; 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table =3D &amp;smu_table-&gt=
;tables[table_index]; @@ -940,14 &#43;940,10 @@<br>
&gt; static int smu_init_fb_allocations(struct smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D smu-&gt;adev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table =3D &amp;smu-&gt;smu_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *tables =3D=
 smu_table-&gt;tables;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_count =3D smu_table-&gt;table=
_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t ret =3D 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (table_count &lt;=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; table_count; i&#43;&#4=
3;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_TABLE_COUNT; i&=
#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(adev,<br>
&gt; @@ -978,13 &#43;974,12 @@ static int smu_fini_fb_allocations(struct<br=
>
&gt; smu_context *smu)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table =3D &amp;smu-&gt;smu_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *tables =3D=
 smu_table-&gt;tables;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t table_count =3D smu_table-&gt;table=
_count;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (table_count =3D=3D 0 || tables =3D=3D NU=
LL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!tables)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0 ; i &lt; table_count; i&#43;&#4=
3;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_TABLE_COUNT; i&=
#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;tables[i].bo,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; index f1f072012fac..6e8eb0f94c8b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&gt; @@ -1934,5 &#43;1934,4 @@ void arcturus_set_ppt_funcs(struct smu_conte=
xt<br>
&gt; *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table =3D &amp;smu-&gt;smu_table;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp;a=
rcturus_ppt_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_count =3D TABLE_COUNT;<b=
r>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; index 744b7501c34d..e3add8b59291 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -1633,5 &#43;1633,4 @@ void navi10_set_ppt_funcs(struct smu_context=
<br>
&gt; *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table =3D &amp;smu-&gt;smu_table;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp;n=
avi10_ppt_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_count =3D TABLE_COUNT;<b=
r>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; index de43159564a5..2b953f7431b6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&gt; @@ -169,5 &#43;169,4 @@ void renoir_set_ppt_funcs(struct smu_context *=
smu)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp;r=
enoir_ppt_funcs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_if_version =3D S=
MU12_DRIVER_IF_VERSION;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_count =3D TABLE_COUNT;<b=
r>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; index deca9f85764c..3709e4d77338 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; @@ -439,7 &#43;439,7 @@ static int smu_v11_0_init_smc_tables(struct<br=
>
&gt; smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *tables =3D=
 NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (smu_table-&gt;tables || smu_table-&gt;ta=
ble_count =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_table-&gt;tables)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tables =3D kcalloc(SMU_TABLE=
_COUNT, sizeof(struct smu_table), @@ -<br>
&gt; 465,13 &#43;465,12 @@ static int smu_v11_0_fini_smc_tables(struct<br>
&gt; smu_context *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table =3D &amp;smu-&gt;smu_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;tables || smu_table-&gt;t=
able_count =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_table-&gt;tables)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;tables);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;metrics_=
table);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;tables =3D NUL=
L;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_count =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_table =
=3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_time =
=3D 0;<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; index 899bf96b23e1..68548ba9b6ea 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; @@ -3189,5 &#43;3189,4 @@ void vega20_set_ppt_funcs(struct smu_context=
<br>
&gt; *smu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *sm=
u_table =3D &amp;smu-&gt;smu_table;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;ppt_funcs =3D &amp;v=
ega20_ppt_funcs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;table_count =3D TABLE_COUNT;<b=
r>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.22.0<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296F888862316BBEB874AC2A2B80MN2PR12MB3296namp_--

--===============1783607258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1783607258==--

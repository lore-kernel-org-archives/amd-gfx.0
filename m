From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/7] drm/qxl: fix incorrect use of the lru_lock
Date: Tue, 8 Aug 2017 08:32:45 +0000
Message-ID: <BLUPR12MB0449BF26DF380111335974ED848A0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1502120903-24080-1-git-send-email-deathsimple@vodafone.de>
 <1502120903-24080-2-git-send-email-deathsimple@vodafone.de>,
 <cddfe54f-2234-5427-f69d-7c379b6b8264@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1620356905=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cddfe54f-2234-5427-f69d-7c379b6b8264-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave
 Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--===============1620356905==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB0449BF26DF380111335974ED848A0BLUPR12MB0449namp_"

--_000_BLUPR12MB0449BF26DF380111335974ED848A0BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ack-by: Monk.Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, August 8, 2017 4:14:46 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Dave Ai=
rlie; Gerd Hoffmann
Subject: Re: [PATCH 2/7] drm/qxl: fix incorrect use of the lru_lock

Hi guys,

can I get an rb or at least an Acked-by for that one?

The code was obviously copied over from radeon where it wasn't correct
in the first place.

Thanks,
Christian.

Am 07.08.2017 um 17:48 schrieb Christian K=F6nig:
> From: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> The BO manager has its own lock and doesn't use the lru_lock.
>
> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/qxl/qxl_ttm.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.=
c
> index 0fdedee..07dc08d 100644
> --- a/drivers/gpu/drm/qxl/qxl_ttm.c
> +++ b/drivers/gpu/drm/qxl/qxl_ttm.c
> @@ -454,15 +454,10 @@ void qxl_ttm_fini(struct qxl_device *qdev)
>   static int qxl_mm_dump_table(struct seq_file *m, void *data)
>   {
>        struct drm_info_node *node =3D (struct drm_info_node *)m->private;
> -     struct drm_mm *mm =3D (struct drm_mm *)node->info_ent->data;
> -     struct drm_device *dev =3D node->minor->dev;
> -     struct qxl_device *rdev =3D dev->dev_private;
> -     struct ttm_bo_global *glob =3D rdev->mman.bdev.glob;
> +     struct ttm_mem_type_manager *man =3D node->info_ent->data;
>        struct drm_printer p =3D drm_seq_file_printer(m);
>
> -     spin_lock(&glob->lru_lock);
> -     drm_mm_print(mm, &p);
> -     spin_unlock(&glob->lru_lock);
> +     man->func->debug(man, &p);
>        return 0;
>   }
>   #endif
> @@ -483,9 +478,9 @@ int qxl_ttm_debugfs_init(struct qxl_device *qdev)
>                qxl_mem_types_list[i].show =3D &qxl_mm_dump_table;
>                qxl_mem_types_list[i].driver_features =3D 0;
>                if (i =3D=3D 0)
> -                     qxl_mem_types_list[i].data =3D qdev->mman.bdev.man[=
TTM_PL_VRAM].priv;
> +                     qxl_mem_types_list[i].data =3D &qdev->mman.bdev.man=
[TTM_PL_VRAM];
>                else
> -                     qxl_mem_types_list[i].data =3D qdev->mman.bdev.man[=
TTM_PL_PRIV].priv;
> +                     qxl_mem_types_list[i].data =3D &qdev->mman.bdev.man=
[TTM_PL_PRIV];
>
>        }
>        return qxl_debugfs_add_files(qdev, qxl_mem_types_list, i);


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB0449BF26DF380111335974ED848A0BLUPR12MB0449namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Ack-by: Monk.Liu &lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;death=
simple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, August 8, 2017 4:14:46 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; =
Dave Airlie; Gerd Hoffmann<br>
<b>Subject:</b> Re: [PATCH 2/7] drm/qxl: fix incorrect use of the lru_lock<=
/font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi guys,<br>
<br>
can I get an rb or at least an Acked-by for that one?<br>
<br>
The code was obviously copied over from radeon where it wasn't correct <br>
in the first place.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 07.08.2017 um 17:48 schrieb Christian K=F6nig:<br>
&gt; From: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; The BO manager has its own lock and doesn't use the lru_lock.<br>
&gt;<br>
&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/qxl/qxl_ttm.c | 13 &#43;&#43;&#43;&#43;---=
------<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_t=
tm.c<br>
&gt; index 0fdedee..07dc08d 100644<br>
&gt; --- a/drivers/gpu/drm/qxl/qxl_ttm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/qxl/qxl_ttm.c<br>
&gt; @@ -454,15 &#43;454,10 @@ void qxl_ttm_fini(struct qxl_device *qdev)<b=
r>
&gt;&nbsp;&nbsp; static int qxl_mm_dump_table(struct seq_file *m, void *dat=
a)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_info_node *node =
=3D (struct drm_info_node *)m-&gt;private;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm *mm =3D (struct drm_mm *)node-=
&gt;info_ent-&gt;data;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D node-&gt;minor-&g=
t;dev;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct qxl_device *rdev =3D dev-&gt;dev_priv=
ate;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_global *glob =3D rdev-&gt;mman=
.bdev.glob;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_mem_type_manager *man =3D nod=
e-&gt;info_ent-&gt;data;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_printer p =3D drm=
_seq_file_printer(m);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;glob-&gt;lru_lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; drm_mm_print(mm, &amp;p);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;glob-&gt;lru_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; man-&gt;func-&gt;debug(man, &amp;p);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; @@ -483,9 &#43;478,9 @@ int qxl_ttm_debugfs_init(struct qxl_device *qd=
ev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qxl_mem_types_list[i].show =3D &amp;qxl_mm_dump_table;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; qxl_mem_types_list[i].driver_features =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (i =3D=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qxl_mem_types_list[i].d=
ata =3D qdev-&gt;mman.bdev.man[TTM_PL_VRAM].priv;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qxl_mem_types_list[=
i].data =3D &amp;qdev-&gt;mman.bdev.man[TTM_PL_VRAM];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qxl_mem_types_list[i].d=
ata =3D qdev-&gt;mman.bdev.man[TTM_PL_PRIV].priv;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qxl_mem_types_list[=
i].data =3D &amp;qdev-&gt;mman.bdev.man[TTM_PL_PRIV];<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return qxl_debugfs_add_files=
(qdev, qxl_mem_types_list, i);<br>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_BLUPR12MB0449BF26DF380111335974ED848A0BLUPR12MB0449namp_--

--===============1620356905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1620356905==--

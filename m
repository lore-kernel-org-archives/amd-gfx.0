From: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: refresh per vm bo lru
Date: Tue, 27 Mar 2018 11:56:05 +0000
Message-ID: <20383.610254112$1522151649@news.gmane.org>
References: <20180327101654.1118-1-david1.zhou@amd.com>
 <20180327101654.1118-2-david1.zhou@amd.com>,
 <6afa6cca-d59c-9e64-f891-c43a741069d4@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0725870553=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6afa6cca-d59c-9e64-f891-c43a741069d4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0725870553==
Content-Language: en-US
Content-Type: multipart/alternative; boundary="_000_smartisan1522151762126_"

--_000_smartisan1522151762126_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

then how to keep unique lru order? any ideas?

To stable performance, we have to keep unique lru order, otherwise like the=
 issue I look into, sometimes F1game is 40fps, sometimes 28fps...even re-va=
lidate allowed domains BO.

The left root cause is the moved BOs are not same.


send from Smartisan Pro

Christian K=1B$BrY=1B(Big <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =1B$BP2=1B(B 2=
018=1B$BG/=1B(B3=1B$B7n=1B(B27=1B$BF|=1B(B =1B$B2<8a=1B(B6:50=1B$B<LF;!'=1B=
(B

NAK, we already tried that and it is really not a good idea because it
massively increases the per submission overhead.

Christian.

Am 27.03.2018 um 12:16 schrieb Chunming Zhou:
> Change-Id: Ibad84ed585b0746867a5f4cd1eadc2273e7cf596
> Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>   3 files changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 383bf2d31c92..414e61799236 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -919,6 +919,8 @@ static int amdgpu_bo_vm_update_pte(struct amdgpu_cs_p=
arser *p)
>                }
>        }
>
> +     amdgpu_vm_refresh_lru(adev, vm);
> +
>        return r;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 5e35e23511cf..8ad2bb705765 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1902,6 +1902,21 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgp=
u_device *adev,
>        return bo_va;
>   }
>
> +void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct amdgpu_vm =
*vm)
> +{
> +     struct ttm_bo_global *glob =3D adev->mman.bdev.glob;
> +     struct amdgpu_vm_bo_base *bo_base;
> +
> +     spin_lock(&vm->status_lock);
> +     list_for_each_entry(bo_base, &vm->vm_bo_list, vm_bo) {
> +             spin_lock(&glob->lru_lock);
> +             ttm_bo_move_to_lru_tail(&bo_base->bo->tbo);
> +             if (bo_base->bo->shadow)
> +                     ttm_bo_move_to_lru_tail(&bo_base->bo->shadow->tbo);
> +             spin_unlock(&glob->lru_lock);
> +     }
> +     spin_unlock(&vm->status_lock);
> +}
>
>   /**
>    * amdgpu_vm_bo_insert_mapping - insert a new mapping
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 1886a561c84e..e01895581489 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -285,6 +285,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>                          struct dma_fence **fence);
>   int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>                           struct amdgpu_vm *vm);
> +void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct amdgpu_vm =
*vm);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>                        struct amdgpu_bo_va *bo_va,
>                        bool clear);


--_000_smartisan1522151762126_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div name=3D"x_smartisanmessageid" id=3D"x_smartisan1522151762126"></div>
<font color=3D"#333333">then how to keep unique lru order? any ideas?<br>
</font><br>
To stable performance, we have to keep unique lru order, otherwise like the=
 issue I look into, sometimes F1game is 40fps, sometimes 28fps...even re-va=
lidate allowed domains BO.<br>
<br>
The left root cause is the moved BOs are not same.<br>
<br>
<span id=3D"x_smartisan_signature" style=3D"font-size:0.8em; display:inline=
; color:#888888">
<p dir=3D"ltr">send from Smartisan Pro</p>
</span><style type=3D"text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
<div class=3D"x_quote">
<div style=3D"margin:0 0px; font-size:105%"><font color=3D"#629140" style=
=3D"line-height:1.4"><span>Christian K=1B$BrY=1B(Big &lt;ckoenig.leichtzume=
rken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; =1B$BP2=1B(B 2018=1B$BG/=1B(B3=1B$B7n=1B(B27=1B$BF|=1B(B=
 =1B$B2<8a=1B(B6:50=1B$B<LF;!'=1B(B</span></font></div>
<br type=3D"attribution">
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">NAK, we already tried that and it is really not a =
good idea because it
<br>
massively increases the per submission overhead.<br>
<br>
Christian.<br>
<br>
Am 27.03.2018 um 12:16 schrieb Chunming Zhou:<br>
&gt; Change-Id: Ibad84ed585b0746867a5f4cd1eadc2273e7cf596<br>
&gt; Signed-off-by: Chunming Zhou &lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |&nbsp; 2 &#43;&#43=
;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |&nbsp; 1 &#43;<br>
&gt;&nbsp;&nbsp; 3 files changed, 18 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index 383bf2d31c92..414e61799236 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -919,6 &#43;919,8 @@ static int amdgpu_bo_vm_update_pte(struct amdg=
pu_cs_parser *p)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_refresh_lru(adev, vm);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 5e35e23511cf..8ad2bb705765 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -1902,6 &#43;1902,21 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struc=
t amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bo_va;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct amd=
gpu_vm *vm)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_bo_global *glob =3D adev-&gt;=
mman.bdev.glob;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *bo_base;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(bo_base, &amp;vm-&gt=
;vm_bo_list, vm_bo) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; spin_lock(&amp;glob-&gt;lru_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ttm_bo_move_to_lru_tail(&amp;bo_base-&gt;bo-&gt;tbo);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (bo_base-&gt;bo-&gt;shadow)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_move_to_lru_=
tail(&amp;bo_base-&gt;bo-&gt;shadow-&gt;tbo);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; spin_unlock(&amp;glob-&gt;lru_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);<br=
>
&gt; &#43;}<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_vm_bo_insert_mapping - insert a new mapping=
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 1886a561c84e..e01895581489 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -285,6 &#43;285,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct dma_fence **fence);<br>
&gt;&nbsp;&nbsp; int amdgpu_vm_handle_moved(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_vm *vm);<br>
&gt; &#43;void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct amd=
gpu_vm *vm);<br>
&gt;&nbsp;&nbsp; int amdgpu_vm_bo_update(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_bo_va *bo_va,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool cl=
ear);<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_smartisan1522151762126_--

--===============0725870553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0725870553==--

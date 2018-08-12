From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH v2 0/5] drm/ttm,
 amdgpu: Introduce LRU bulk move functionality
Date: Sun, 12 Aug 2018 22:12:56 +0100
Message-ID: <CAHbf0-F-0y-nss2Dd8SGBLhbiO49H4EA9wEgFBTL0ZjgnmvjOQ@mail.gmail.com>
References: <1533902159-14232-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1605430962=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1533902159-14232-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1605430962==
Content-Type: multipart/alternative; boundary="0000000000008b72fc05734371f9"

--0000000000008b72fc05734371f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I've been testing these patches over the weekend on my Tonga and Raven
systems

Tested-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>

Cheers

Mike

On Fri, 10 Aug 2018 at 12:56 Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org> wrote:

> The idea and proposal is originally from Christian, and I continue to wor=
k
> to
> deliver it.
>
> Background:
> amdgpu driver will move all PD/PT and PerVM BOs into idle list. Then move
> all of
> them on the end of LRU list one by one. Thus, that cause so many BOs move=
d
> to
> the end of the LRU, and impact performance seriously.
>
> Then Christian provided a workaround to not move PD/PT BOs on LRU with
> below
> patch:
> "drm/amdgpu: band aid validating VM PTs"
> Commit 0bbf32026cf5ba41e9922b30e26e1bed1ecd38ae
>
> However, the final solution should bulk move all PD/PT and PerVM BOs on
> the LRU
> instead of one by one.
>
> Whenever amdgpu_vm_validate_pt_bos() is called and we have BOs which need
> to be
> validated we move all BOs together to the end of the LRU without dropping
> the
> lock for the LRU.
>
> While doing so we note the beginning and end of this block in the LRU lis=
t.
>
> Now when amdgpu_vm_validate_pt_bos() is called and we don't have anything
> to do,
> we don't move every BO one by one, but instead cut the LRU list into
> pieces so
> that we bulk move everything to the end in just one operation.
>
> Test data:
>
> +--------------+-----------------+-----------+---------------------------=
------------+
> |              |The Talos        |Clpeak(OCL)|BusSpeedReadback(OCL)
>           |
> |              |Principle(Vulkan)|           |
>            |
>
> +------------------------------------------------------------------------=
------------+
> |              |                 |           |0.319 ms(1k) 0.314 ms(2K)
> 0.308 ms(4K) |
> | Original     |  147.7 FPS      |  76.86 us |0.307 ms(8K) 0.310 ms(16K)
>            |
>
> +------------------------------------------------------------------------=
------------+
> | Orignial + WA|                 |           |0.254 ms(1K) 0.241 ms(2K)
>           |
> |(don't move   |  162.1 FPS      |  42.15 us |0.230 ms(4K) 0.223 ms(8K)
> 0.204 ms(16K)|
> |PT BOs on LRU)|                 |           |
>            |
>
> +------------------------------------------------------------------------=
------------+
> | Bulk move    |  163.1 FPS      |  40.52 us |0.244 ms(1K) 0.252 ms(2K)
> 0.213 ms(4K) |
> |              |                 |           |0.214 ms(8K) 0.225 ms(16K)
>            |
>
> +--------------+-----------------+-----------+---------------------------=
------------+
>
> After test them with above three benchmarks include vulkan and opencl. We
> can
> see the visible improvement than original, and even better than original
> with
> workaround.
>
> Changes from V1 -> V2:
> - Fix to missed the BOs in relocated/moved that should be also moved to
> the end
>   of LRU.
>
> Thanks,
> Rui
>
> Christian K=C3=B6nig (2):
>   drm/ttm: add helper structures for bulk moves on lru list
>   drm/ttm: revise ttm_bo_move_to_lru_tail to support bulk moves
>
> Huang Rui (3):
>   drm/ttm: add bulk move function on LRU
>   drm/amdgpu: use bulk moves for efficient VM LRU handling (v2)
>   drm/amdgpu: move PD/PT bos on LRU again
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 77
> +++++++++++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  4 ++
>  drivers/gpu/drm/ttm/ttm_bo.c           | 78
> +++++++++++++++++++++++++++++++++-
>  include/drm/ttm/ttm_bo_api.h           | 16 ++++++-
>  include/drm/ttm/ttm_bo_driver.h        | 28 ++++++++++++
>  5 files changed, 184 insertions(+), 19 deletions(-)
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008b72fc05734371f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I&#39;ve been testing these patches =
over the weekend on my Tonga and Raven systems</div><div><br></div><div>Tes=
ted-by: Mike Lothian &lt;<a href=3D"mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org">mike@firebu=
rn.co.uk</a>&gt;</div><div><br></div><div>Cheers</div><div><br></div><div>M=
ike</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 10 A=
ug 2018 at 12:56 Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.hua=
ng-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The idea=
 and proposal is originally from Christian, and I continue to work to<br>
deliver it.<br>
<br>
Background:<br>
amdgpu driver will move all PD/PT and PerVM BOs into idle list. Then move a=
ll of<br>
them on the end of LRU list one by one. Thus, that cause so many BOs moved =
to<br>
the end of the LRU, and impact performance seriously.<br>
<br>
Then Christian provided a workaround to not move PD/PT BOs on LRU with belo=
w<br>
patch:<br>
&quot;drm/amdgpu: band aid validating VM PTs&quot;<br>
Commit 0bbf32026cf5ba41e9922b30e26e1bed1ecd38ae<br>
<br>
However, the final solution should bulk move all PD/PT and PerVM BOs on the=
 LRU<br>
instead of one by one.<br>
<br>
Whenever amdgpu_vm_validate_pt_bos() is called and we have BOs which need t=
o be<br>
validated we move all BOs together to the end of the LRU without dropping t=
he<br>
lock for the LRU.<br>
<br>
While doing so we note the beginning and end of this block in the LRU list.=
<br>
<br>
Now when amdgpu_vm_validate_pt_bos() is called and we don&#39;t have anythi=
ng to do,<br>
we don&#39;t move every BO one by one, but instead cut the LRU list into pi=
eces so<br>
that we bulk move everything to the end in just one operation.<br>
<br>
Test data:<br>
+--------------+-----------------+-----------+-----------------------------=
----------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |The Talos=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |Clpeak(OCL)|BusSpeedReadback(OCL)=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |Principle(Vulkan)|=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
+--------------------------------------------------------------------------=
----------+<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|0.319 ms(1k) 0.314 ms(2K) 0.308 ms(4K) |<br>
| Original=C2=A0 =C2=A0 =C2=A0|=C2=A0 147.7 FPS=C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 76.86 us |0.307 ms(8K) 0.310 ms(16K)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|<br>
+--------------------------------------------------------------------------=
----------+<br>
| Orignial + WA|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|0.254 ms(1K) 0.241 ms(2K)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
|(don&#39;t move=C2=A0 =C2=A0|=C2=A0 162.1 FPS=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
42.15 us |0.230 ms(4K) 0.223 ms(8K) 0.204 ms(16K)|<br>
|PT BOs on LRU)|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
+--------------------------------------------------------------------------=
----------+<br>
| Bulk move=C2=A0 =C2=A0 |=C2=A0 163.1 FPS=C2=A0 =C2=A0 =C2=A0 |=C2=A0 40.5=
2 us |0.244 ms(1K) 0.252 ms(2K) 0.213 ms(4K) |<br>
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|0.214 ms(8K) 0.225 ms(16K)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|<br>
+--------------+-----------------+-----------+-----------------------------=
----------+<br>
<br>
After test them with above three benchmarks include vulkan and opencl. We c=
an<br>
see the visible improvement than original, and even better than original wi=
th<br>
workaround.<br>
<br>
Changes from V1 -&gt; V2:<br>
- Fix to missed the BOs in relocated/moved that should be also moved to the=
 end<br>
=C2=A0 of LRU.<br>
<br>
Thanks,<br>
Rui<br>
<br>
Christian K=C3=B6nig (2):<br>
=C2=A0 drm/ttm: add helper structures for bulk moves on lru list<br>
=C2=A0 drm/ttm: revise ttm_bo_move_to_lru_tail to support bulk moves<br>
<br>
Huang Rui (3):<br>
=C2=A0 drm/ttm: add bulk move function on LRU<br>
=C2=A0 drm/amdgpu: use bulk moves for efficient VM LRU handling (v2)<br>
=C2=A0 drm/amdgpu: move PD/PT bos on LRU again<br>
<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 77 +++++++++++++++++++++++++=
--------<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |=C2=A0 4 ++<br>
=C2=A0drivers/gpu/drm/ttm/ttm_bo.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 78 +++++++++++++++++++++++++++++++++-<br>
=C2=A0include/drm/ttm/ttm_bo_api.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 16 ++++++-<br>
=C2=A0include/drm/ttm/ttm_bo_driver.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 28 +++++=
+++++++<br>
=C2=A05 files changed, 184 insertions(+), 19 deletions(-)<br>
<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000008b72fc05734371f9--

--===============1605430962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1605430962==--

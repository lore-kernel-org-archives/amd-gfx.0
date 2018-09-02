From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v5 0/5] drm/ttm,amdgpu: Introduce LRU bulk move
 functionality
Date: Sun, 2 Sep 2018 15:11:05 +0000
Message-ID: <0d84489b-9bed-46d7-a2a0-c59585578683@email.android.com>
References: <1534924375-5837-1-git-send-email-ray.huang@amd.com>
 <51ebd226-3290-5ea5-e272-0d566a119aca@gmail.com>
 <20180822084304.GG28364@hr-amur2>,
 <CAHbf0-GsMRx9uZp=FRMf947-BNocaCegiP8W3+w65tOhykOpvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1894637099=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHbf0-GsMRx9uZp=FRMf947-BNocaCegiP8W3+w65tOhykOpvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: de-DE
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
To: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1894637099==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_0d84489b9bed46d7a2a0c59585578683emailandroidcom_"

--_000_0d84489b9bed46d7a2a0c59585578683emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

That one is already committed to amd-staging-drm-next.

But I've fixed a few bugs with that just yesterday, not sure if the public =
copy of amd-staging-drm-next is already up to date.

Christian.

Am 02.09.2018 10:12 schrieb Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>:
Hi

Is there an updated series? These no longer apply for me

Thanks

Mike

On Wed, 22 Aug 2018 at 09:42 Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org<mailto:ray.huang@=
amd.com>> wrote:
On Wed, Aug 22, 2018 at 04:24:02PM +0800, Christian K=F6nig wrote:
> Please commit patches #1, #2 and #3, doesn't make much sense to send
> them out even more often.
>
> Jerry's comments on patch #4 sound valid to me as well, but with those
> minor issues fixes/commented I think we can commit it.
>
> Thanks for taking care of this,
> Christian.

OK. Thanks to your time.

Thanks,
Ray

>
> Am 22.08.2018 um 09:52 schrieb Huang Rui:
> > The idea and proposal is originally from Christian, and I continue to w=
ork to
> > deliver it.
> >
> > Background:
> > amdgpu driver will move all PD/PT and PerVM BOs into idle list. Then mo=
ve all of
> > them on the end of LRU list one by one. Thus, that cause so many BOs mo=
ved to
> > the end of the LRU, and impact performance seriously.
> >
> > Then Christian provided a workaround to not move PD/PT BOs on LRU with =
below
> > patch:
> > Commit 0bbf32026cf5ba41e9922b30e26e1bed1ecd38ae ("drm/amdgpu: band aid
> > validating VM PTs")
> >
> > However, the final solution should bulk move all PD/PT and PerVM BOs on=
 the LRU
> > instead of one by one.
> >
> > Whenever amdgpu_vm_validate_pt_bos() is called and we have BOs which ne=
ed to be
> > validated we move all BOs together to the end of the LRU without droppi=
ng the
> > lock for the LRU.
> >
> > While doing so we note the beginning and end of this block in the LRU l=
ist.
> >
> > Now when amdgpu_vm_validate_pt_bos() is called and we don't have anythi=
ng to do,
> > we don't move every BO one by one, but instead cut the LRU list into pi=
eces so
> > that we bulk move everything to the end in just one operation.
> >
> > Test data:
> > +--------------+-----------------+-----------+-------------------------=
--------------+
> > |              |The Talos        |Clpeak(OCL)|BusSpeedReadback(OCL)    =
              |
> > |              |Principle(Vulkan)|           |                         =
              |
> > +----------------------------------------------------------------------=
--------------+
> > |              |                 |           |0.319 ms(1k) 0.314 ms(2K)=
 0.308 ms(4K) |
> > | Original     |  147.7 FPS      |  76.86 us |0.307 ms(8K) 0.310 ms(16K=
)             |
> > +----------------------------------------------------------------------=
--------------+
> > | Orignial + WA|                 |           |0.254 ms(1K) 0.241 ms(2K)=
              |
> > |(don't move   |  162.1 FPS      |  42.15 us |0.230 ms(4K) 0.223 ms(8K)=
 0.204 ms(16K)|
> > |PT BOs on LRU)|                 |           |                         =
              |
> > +----------------------------------------------------------------------=
--------------+
> > | Bulk move    |  163.1 FPS      |  40.52 us |0.244 ms(1K) 0.252 ms(2K)=
 0.213 ms(4K) |
> > |              |                 |           |0.214 ms(8K) 0.225 ms(16K=
)             |
> > +--------------+-----------------+-----------+-------------------------=
--------------+
> >
> > After test them with above three benchmarks include vulkan and opencl. =
We can
> > see the visible improvement than original, and even better than origina=
l with
> > workaround.
> >
> > Changes from V1 -> V2:
> > - Fix to missed the BOs in relocated/moved that should be also moved to=
 the end
> >    of LRU.
> >
> > Changes from V2 -> V3:
> > - Remove unused parameter and use list_for_each_entry instead of the on=
e with
> >    save entry.
> >
> > Changes from V3 -> V4:
> > - Move the amdgpu_vm_move_to_lru_tail after command submission, at that=
 time,
> >    all bo will be back on idle list.
> >
> > Changes from V4 -> V5:
> > - Remove amdgpu_vm_move_to_lru_tail_by_list(), use bulk_moveable instre=
ad of
> >    validated, and move ttm_bo_bulk_move_lru_tail() also into
> >    amdgpu_vm_move_to_lru_tail().
> >
> > Thanks,
> > Ray
> >
> > Christian K=F6nig (2):
> >    drm/ttm: add helper structures for bulk moves on lru list
> >    drm/ttm: revise ttm_bo_move_to_lru_tail to support bulk moves
> >
> > Huang Rui (3):
> >    drm/ttm: add bulk move function on LRU
> >    drm/amdgpu: use bulk moves for efficient VM LRU handling (v5)
> >    drm/amdgpu: move PD/PT bos on LRU again
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 +++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 68 +++++++++++++++++++------=
----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 11 ++++-
> >   drivers/gpu/drm/ttm/ttm_bo.c           | 78 +++++++++++++++++++++++++=
++++++++-
> >   include/drm/ttm/ttm_bo_api.h           | 16 ++++++-
> >   include/drm/ttm/ttm_bo_driver.h        | 28 ++++++++++++
> >   6 files changed, 186 insertions(+), 25 deletions(-)
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_0d84489b9bed46d7a2a0c59585578683emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta content=3D"text/html; charset=3Dutf-8">
</head>
<body>
<div dir=3D"auto">That one is already committed to amd-staging-drm-next.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">But I've fixed a few bugs with that just yesterday, not s=
ure if the public copy of amd-staging-drm-next is already up to date.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 02.09.2018 10:12 schrieb Mike Lothian &lt;mik=
e@fireburn.co.uk&gt;:<br type=3D"attribution">
</div>
</div>
<div>
<div dir=3D"ltr">Hi
<div><br>
</div>
<div>Is there an updated series? These no longer apply for me&nbsp;</div>
<div><br>
</div>
<div>Thanks</div>
<div><br>
</div>
<div>Mike</div>
</div>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Wed, 22 Aug 2018 at 09:42 Huang Rui &lt;<a href=3D"mail=
to:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.huang-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
On Wed, Aug 22, 2018 at 04:24:02PM &#43;0800, Christian K=F6nig wrote:<br>
&gt; Please commit patches #1, #2 and #3, doesn't make much sense to send <=
br>
&gt; them out even more often.<br>
&gt; <br>
&gt; Jerry's comments on patch #4 sound valid to me as well, but with those=
 <br>
&gt; minor issues fixes/commented I think we can commit it.<br>
&gt; <br>
&gt; Thanks for taking care of this,<br>
&gt; Christian.<br>
<br>
OK. Thanks to your time.<br>
<br>
Thanks,<br>
Ray<br>
<br>
&gt; <br>
&gt; Am 22.08.2018 um 09:52 schrieb Huang Rui:<br>
&gt; &gt; The idea and proposal is originally from Christian, and I continu=
e to work to<br>
&gt; &gt; deliver it.<br>
&gt; &gt;<br>
&gt; &gt; Background:<br>
&gt; &gt; amdgpu driver will move all PD/PT and PerVM BOs into idle list. T=
hen move all of<br>
&gt; &gt; them on the end of LRU list one by one. Thus, that cause so many =
BOs moved to<br>
&gt; &gt; the end of the LRU, and impact performance seriously.<br>
&gt; &gt;<br>
&gt; &gt; Then Christian provided a workaround to not move PD/PT BOs on LRU=
 with below<br>
&gt; &gt; patch:<br>
&gt; &gt; Commit 0bbf32026cf5ba41e9922b30e26e1bed1ecd38ae (&quot;drm/amdgpu=
: band aid<br>
&gt; &gt; validating VM PTs&quot;)<br>
&gt; &gt;<br>
&gt; &gt; However, the final solution should bulk move all PD/PT and PerVM =
BOs on the LRU<br>
&gt; &gt; instead of one by one.<br>
&gt; &gt;<br>
&gt; &gt; Whenever amdgpu_vm_validate_pt_bos() is called and we have BOs wh=
ich need to be<br>
&gt; &gt; validated we move all BOs together to the end of the LRU without =
dropping the<br>
&gt; &gt; lock for the LRU.<br>
&gt; &gt;<br>
&gt; &gt; While doing so we note the beginning and end of this block in the=
 LRU list.<br>
&gt; &gt;<br>
&gt; &gt; Now when amdgpu_vm_validate_pt_bos() is called and we don't have =
anything to do,<br>
&gt; &gt; we don't move every BO one by one, but instead cut the LRU list i=
nto pieces so<br>
&gt; &gt; that we bulk move everything to the end in just one operation.<br=
>
&gt; &gt;<br>
&gt; &gt; Test data:<br>
&gt; &gt; &#43;--------------&#43;-----------------&#43;-----------&#43;---=
------------------------------------&#43;<br>
&gt; &gt; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |The Talos&nbsp=
; &nbsp; &nbsp; &nbsp; |Clpeak(OCL)|BusSpeedReadback(OCL)&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |<br>
&gt; &gt; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |Principle(Vulk=
an)|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &gt; &#43;------------------------------------------------------------=
------------------------&#43;<br>
&gt; &gt; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;|0.319 ms(1k) 0.314 ms(2K) 0.308 ms(4K) |<br>
&gt; &gt; | Original&nbsp; &nbsp; &nbsp;|&nbsp; 147.7 FPS&nbsp; &nbsp; &nbs=
p; |&nbsp; 76.86 us |0.307 ms(8K) 0.310 ms(16K)&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;|<br>
&gt; &gt; &#43;------------------------------------------------------------=
------------------------&#43;<br>
&gt; &gt; | Orignial &#43; WA|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|0.254 ms(1K) 0.=
241 ms(2K)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |<br>
&gt; &gt; |(don't move&nbsp; &nbsp;|&nbsp; 162.1 FPS&nbsp; &nbsp; &nbsp; |&=
nbsp; 42.15 us |0.230 ms(4K) 0.223 ms(8K) 0.204 ms(16K)|<br>
&gt; &gt; |PT BOs on LRU)|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &gt; &#43;------------------------------------------------------------=
------------------------&#43;<br>
&gt; &gt; | Bulk move&nbsp; &nbsp; |&nbsp; 163.1 FPS&nbsp; &nbsp; &nbsp; |&=
nbsp; 40.52 us |0.244 ms(1K) 0.252 ms(2K) 0.213 ms(4K) |<br>
&gt; &gt; |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;|0.214 ms(8K) 0.225 ms(16K)&nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;|<br>
&gt; &gt; &#43;--------------&#43;-----------------&#43;-----------&#43;---=
------------------------------------&#43;<br>
&gt; &gt;<br>
&gt; &gt; After test them with above three benchmarks include vulkan and op=
encl. We can<br>
&gt; &gt; see the visible improvement than original, and even better than o=
riginal with<br>
&gt; &gt; workaround.<br>
&gt; &gt;<br>
&gt; &gt; Changes from V1 -&gt; V2:<br>
&gt; &gt; - Fix to missed the BOs in relocated/moved that should be also mo=
ved to the end<br>
&gt; &gt;&nbsp; &nbsp; of LRU.<br>
&gt; &gt;<br>
&gt; &gt; Changes from V2 -&gt; V3:<br>
&gt; &gt; - Remove unused parameter and use list_for_each_entry instead of =
the one with<br>
&gt; &gt;&nbsp; &nbsp; save entry.<br>
&gt; &gt;<br>
&gt; &gt; Changes from V3 -&gt; V4:<br>
&gt; &gt; - Move the amdgpu_vm_move_to_lru_tail after command submission, a=
t that time,<br>
&gt; &gt;&nbsp; &nbsp; all bo will be back on idle list.<br>
&gt; &gt;<br>
&gt; &gt; Changes from V4 -&gt; V5:<br>
&gt; &gt; - Remove amdgpu_vm_move_to_lru_tail_by_list(), use bulk_moveable =
instread of<br>
&gt; &gt;&nbsp; &nbsp; validated, and move ttm_bo_bulk_move_lru_tail() also=
 into<br>
&gt; &gt;&nbsp; &nbsp; amdgpu_vm_move_to_lru_tail().<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt; Ray<br>
&gt; &gt;<br>
&gt; &gt; Christian K=F6nig (2):<br>
&gt; &gt;&nbsp; &nbsp; drm/ttm: add helper structures for bulk moves on lru=
 list<br>
&gt; &gt;&nbsp; &nbsp; drm/ttm: revise ttm_bo_move_to_lru_tail to support b=
ulk moves<br>
&gt; &gt;<br>
&gt; &gt; Huang Rui (3):<br>
&gt; &gt;&nbsp; &nbsp; drm/ttm: add bulk move function on LRU<br>
&gt; &gt;&nbsp; &nbsp; drm/amdgpu: use bulk moves for efficient VM LRU hand=
ling (v5)<br>
&gt; &gt;&nbsp; &nbsp; drm/amdgpu: move PD/PT bos on LRU again<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 &#43;&#43=
;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 68 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;----------<br>
&gt; &gt;&nbsp; &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 11 &#43;&#43=
;&#43;&#43;-<br>
&gt; &gt;&nbsp; &nbsp;drivers/gpu/drm/ttm/ttm_bo.c&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;| 78 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt;&nbsp; &nbsp;include/drm/ttm/ttm_bo_api.h&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;| 16 &#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt;&nbsp; &nbsp;include/drm/ttm/ttm_bo_driver.h&nbsp; &nbsp; &nbsp; &=
nbsp; | 28 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; &nbsp;6 files changed, 186 insertions(&#43;), 25 deletions(=
-)<br>
&gt; &gt;<br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote>
</div>
</div>
</body>
</html>

--_000_0d84489b9bed46d7a2a0c59585578683emailandroidcom_--

--===============1894637099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1894637099==--

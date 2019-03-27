From: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Add preferred_domain check when determine
 XGMI state
Date: Wed, 27 Mar 2019 15:43:26 +0000
Message-ID: <7a3199ec-c851-6b50-7e1f-b467e5e78d13@amd.com>
References: <1553632516-23346-1-git-send-email-shaoyun.liu@amd.com>
 <c42cc872-cddf-01b9-b46e-b2084f8a1bc3@gmail.com>
 <5d6e562d-012b-f22b-7ec9-2fdf33a9319d@amd.com>
 <3e28a7df-4165-4bde-8a2e-926453ceb1d1@email.android.com>
 <fd7f4b68-26c2-d0ea-b254-fbc61a0d3956@amd.com>
 <68f7ccfa-646e-492f-bdd7-b24f2e2029da@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1782408753=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <68f7ccfa-646e-492f-bdd7-b24f2e2029da-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1782408753==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_7a3199ecc8516b507e1fb467e5e78d13amdcom_"

--_000_7a3199ecc8516b507e1fb467e5e78d13amdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

bool  is_xgmi is added in bo_va structure , this change won't increase the =
size of   struct amdgpu_vm_bo_base. Anyway , can I said it's reviewed by yo=
u now?

shaoyun.liu

On 2019-03-27 11:39 a.m., Koenig, Christian wrote:
Yeah, that one is intentionally very small because it is used so often.

When it grows over the next power of two by this change we need to figure o=
ut a different approach.

Christian.

Am 27.03.2019 16:34 schrieb "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org><mailto:Sha=
oyun.Liu-5C7GfCeVMHo@public.gmane.org>:

you mean struct amdgpu_vm_bo_base ? It only  has few pointer and  a list_he=
ad , should be  pretty small .

struct amdgpu_vm_bo_base {
    /* constant after initialization */
    struct amdgpu_vm        *vm;
    struct amdgpu_bo        *bo;

    /* protected by bo being reserved */
    struct amdgpu_vm_bo_base    *next;

    /* protected by spinlock */
    struct list_head        vm_status;

    /* protected by the BO being reserved */
    bool                moved;
};

shaoyun.liu

On 2019-03-27 11:30 a.m., Koenig, Christian wrote:
Ah, of course. In this case feel free to go ahead.
 BTW: What's the size of the structure now?

Christian.

Am 27.03.2019 16:22 schrieb "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org><mailto:Sha=
oyun.Liu-5C7GfCeVMHo@public.gmane.org>:
The  next in struct amdgpu_vm_bo_base  is not a  list_head,  I'm not
sure whether we can use list_for_each_entry here.

Regards

shaoyun.liu

On 2019-03-27 3:41 a.m., Christian K=F6nig wrote:
> Am 26.03.19 um 21:35 schrieb Liu, Shaoyun:
>> Avoid unnecessary XGMI hight pstate trigger when mapping none-vram
>> memory for peer device
>>
>> Change-Id: I1881deff3da19f1f4b58d5765db03a590092a5b2
>> Signed-off-by: shaoyunl <shaoyun.liu-5C7GfCeVMHo@public.gmane.org><mailto:shaoyun.liu-5C7GfCeVMHo@public.gmane.org=
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  3 ++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index a82c3b1..a0f56e4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -666,6 +666,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev,
>> void *data,
>>       struct amdgpu_device *adev =3D dev->dev_private;
>>       struct drm_amdgpu_gem_op *args =3D data;
>>       struct drm_gem_object *gobj;
>> +    struct amdgpu_vm_bo_base *base;
>> +    struct amdgpu_bo_va *bo_va;
>>       struct amdgpu_bo *robj;
>>       int r;
>>   @@ -704,6 +706,15 @@ int amdgpu_gem_op_ioctl(struct drm_device
>> *dev, void *data,
>>               amdgpu_bo_unreserve(robj);
>>               break;
>>           }
>> +        for (base =3D robj->vm_bo; base; base =3D base->next) {
>> +            bo_va =3D container_of(base, struct amdgpu_bo_va, base);
>
> Please use list_for_each_entry here instead of open coding it.
>
> Christian.
>
>> +            if (bo_va && bo_va->is_xgmi) {
>> +                r =3D -EINVAL;
>> +                amdgpu_bo_unreserve(robj);
>> +                goto out;
>> +            }
>> +        }
>> +
>>           robj->preferred_domains =3D args->value &
>> (AMDGPU_GEM_DOMAIN_VRAM |
>>                               AMDGPU_GEM_DOMAIN_GTT |
>>                               AMDGPU_GEM_DOMAIN_CPU);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 76eee7e..8ed23d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2048,7 +2048,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct
>> amdgpu_device *adev,
>>       INIT_LIST_HEAD(&bo_va->valids);
>>       INIT_LIST_HEAD(&bo_va->invalids);
>>   -    if (bo && amdgpu_xgmi_same_hive(adev,
>> amdgpu_ttm_adev(bo->tbo.bdev))) {
>> +    if (bo && amdgpu_xgmi_same_hive(adev,
>> amdgpu_ttm_adev(bo->tbo.bdev)) &&
>> +        (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)) {
>>           bo_va->is_xgmi =3D true;
>>           mutex_lock(&adev->vm_manager.lock_pstate);
>>           /* Power up XGMI if it can be potentially used */
>



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_7a3199ecc8516b507e1fb467e5e78d13amdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <4CE7CB2299441F4DBD50430CA3B48E08-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<p>bool&nbsp; is_xgmi is added in bo_va structure , this change won't incre=
ase the size of &nbsp; struct amdgpu_vm_bo_base. Anyway , can I said it's r=
eviewed by you now?
<br>
</p>
<p>shaoyun.liu<br>
</p>
<div class=3D"moz-cite-prefix">On 2019-03-27 11:39 a.m., Koenig, Christian =
wrote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:68f7ccfa-646e-492f-bdd7-b24f2e2029da@=
email.android.com">
<meta content=3D"text/html; charset=3Dutf-8">
<div dir=3D"auto">Yeah, that one is intentionally very small because it is =
used so often.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">When it grows over the next power of two by this change w=
e need to figure out a different approach.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 27.03.2019 16:34 schrieb &quot;Liu, Shaoyun&q=
uot; <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org"=
>
&lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br type=3D"attribution">
</div>
</div>
<div>
<p>you mean struct amdgpu_vm_bo_base ? It only&nbsp; has few pointer and&nb=
sp; a list_head , should be&nbsp; pretty small .
<br>
</p>
<p>struct amdgpu_vm_bo_base {<br>
&nbsp;&nbsp;&nbsp; /* constant after initialization */<br>
&nbsp;&nbsp;&nbsp; struct amdgpu_vm&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *v=
m;<br>
&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *b=
o;<br>
<br>
&nbsp;&nbsp;&nbsp; /* protected by bo being reserved */<br>
&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base&nbsp;&nbsp;&nbsp; *next;<br>
<br>
&nbsp;&nbsp;&nbsp; /* protected by spinlock */<br>
&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; vm=
_status;<br>
<br>
&nbsp;&nbsp;&nbsp; /* protected by the BO being reserved */<br>
&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; moved;<br>
};<br>
</p>
<p>shaoyun.liu<br>
</p>
<div class=3D"moz-cite-prefix">On 2019-03-27 11:30 a.m., Koenig, Christian =
wrote:<br>
</div>
<blockquote type=3D"cite">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<style>
<!--
.EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
<div>
<div dir=3D"auto">Ah, of course. In this case feel free to go ahead.
<div dir=3D"auto">&nbsp;BTW: What's the size of the structure now?</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 27.03.2019 16:22 schrieb &quot;Liu, Shaoyun=
&quot; <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Shaoyun.Liu-urvtwAKJhsc@public.gmane.org=
m" moz-do-not-send=3D"true">
&lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt">
<div class=3D"PlainText">The&nbsp; next in struct amdgpu_vm_bo_base&nbsp; i=
s not a&nbsp; list_head,&nbsp; I'm not
<br>
sure whether we can use list_for_each_entry here.<br>
<br>
Regards<br>
<br>
shaoyun.liu<br>
<br>
On 2019-03-27 3:41 a.m., Christian K=F6nig wrote:<br>
&gt; Am 26.03.19 um 21:35 schrieb Liu, Shaoyun:<br>
&gt;&gt; Avoid unnecessary XGMI hight pstate trigger when mapping none-vram=
 <br>
&gt;&gt; memory for peer device<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: I1881deff3da19f1f4b58d5765db03a590092a5b2<br>
&gt;&gt; Signed-off-by: shaoyunl <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:shaoyun.liu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send=3D"true">
&lt;shaoyun.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt; &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp; |&nbsp; 3 &#43=
;&#43;-<br>
&gt;&gt; &nbsp; 2 files changed, 13 insertions(&#43;), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt; index a82c3b1..a0f56e4 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt;&gt; @@ -666,6 &#43;666,8 @@ int amdgpu_gem_op_ioctl(struct drm_device =
*dev, <br>
&gt;&gt; void *data,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-=
&gt;dev_private;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_gem_op *args =3D =
data;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *gobj;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *base;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *robj;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&gt; &nbsp; @@ -704,6 &#43;706,15 @@ int amdgpu_gem_op_ioctl(struct drm=
_device <br>
&gt;&gt; *dev, void *data,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; amdgpu_bo_unreserve(robj);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (base =3D robj=
-&gt;vm_bo; base; base =3D base-&gt;next) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; bo_va =3D container_of(base, struct amdgpu_bo_va, base);<br>
&gt;<br>
&gt; Please use list_for_each_entry here instead of open coding it.<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (bo_va &amp;&amp; bo_va-&gt;is_xgmi) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EINVAL;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(robj);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; &#43;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; robj-&gt;pr=
eferred_domains =3D args-&gt;value &amp; <br>
&gt;&gt; (AMDGPU_GEM_DOMAIN_VRAM |<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT |<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_CPU);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; index 76eee7e..8ed23d2 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; @@ -2048,7 &#43;2048,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(st=
ruct <br>
&gt;&gt; amdgpu_device *adev,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;bo_va-&gt;valid=
s);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;bo_va-&gt;inval=
ids);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp; if (bo &amp;&amp; amdgpu_xgmi_same_hive=
(adev, <br>
&gt;&gt; amdgpu_ttm_adev(bo-&gt;tbo.bdev))) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (bo &amp;&amp; amdgpu_xgmi_same_hive(ad=
ev, <br>
&gt;&gt; amdgpu_ttm_adev(bo-&gt;tbo.bdev)) &amp;&amp;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bo-&gt;preferred_=
domains &amp; AMDGPU_GEM_DOMAIN_VRAM)) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va-&gt;i=
s_xgmi =3D true;<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(=
&amp;adev-&gt;vm_manager.lock_pstate);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Power up=
 XGMI if it can be potentially used */<br>
&gt;<br>
</div>
</span></font></blockquote>
</div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
<pre class=3D"moz-quote-pre" wrap=3D"">____________________________________=
___________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a></pre>
</blockquote>
</body>
</html>

--_000_7a3199ecc8516b507e1fb467e5e78d13amdcom_--

--===============1782408753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1782408753==--

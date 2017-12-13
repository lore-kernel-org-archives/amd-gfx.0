From: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: RE: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses
 dma buf.
Date: Wed, 13 Dec 2017 21:28:04 +0000
Message-ID: <BLUPR12MB06283F027DB3101FEDFF46A0F5350@BLUPR12MB0628.namprd12.prod.outlook.com>
References: <1512771734-13581-1-git-send-email-Samuel.Li@amd.com>
 <BLUPR12MB0628724406FBB250987B1B41F5340@BLUPR12MB0628.namprd12.prod.outlook.com>
 <212eeef1-2c32-bef9-82a6-a1884ef002da@amd.com>
 <82599e20-60fa-fe6f-2c91-4882ffcff4ce@amd.com>
 <154804e5-cdbb-a5f8-2ad8-506b0752943b@amd.com>
 <53b66de8-3fe3-c139-9887-7358bf1d95b5@amd.com>
 <141a2180-104a-4a75-7757-6de3b522c578@amd.com>,
 <e92edd07-27fb-4717-bddd-e97ce5fbc266@amd.com>
 <BN6PR12MB1652331B4826780B9442CA67F7350@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0174282710=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652331B4826780B9442CA67F7350-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0174282710==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB06283F027DB3101FEDFF46A0F5350BLUPR12MB0628namp_"

--_000_BLUPR12MB06283F027DB3101FEDFF46A0F5350BLUPR12MB0628namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Will do after some basic testing.

Sam

From: Deucher, Alexander
Sent: Wednesday, December 13, 2017 2:49 PM
To: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig@amd=
.com>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses=
 dma buf.


Please send the drm prime patch to dri-devel if you didn't already.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org<mailto:s=
amuel.li-5C7GfCeVMHo@public.gmane.org>>
Sent: Wednesday, December 13, 2017 2:17:49 PM
To: Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lists.f=
reedesktop.org>
Subject: Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses=
 dma buf.

For the record.


On 2017-12-13 01:26 PM, Christian K=F6nig wrote:
> Actually we try to avoid that drivers define their own dma_buf_ops in DRM=
.
>
> That's why you have all those callbacks in drm_driver which just mirror t=
he dma_buf interface but unpack the GEM object from the dma-buf object.
>
> There are quite a number of exceptions, but those drivers then implement =
everything on their own because the DRM marshaling doesn't make sense for t=
hem.
>
> Christian.
>
> Am 13.12.2017 um 19:01 schrieb Samuel Li:
>> That is an approach. The cost is to add a new call back, which is not ne=
cessary though, since driver can always actually define their own dma_buf_o=
ps.
>> The intention here is to allow a driver reuse drm_gem_prime_dmabuf_ops{}=
. If you would like to go this far, maybe a more straight forward way is to=
 export those ops, e.g. drm_gem_map_attach, so that a driver can use them i=
n its own definitions.
>>
>> Sam
>>
>>
>>
>> On 2017-12-13 05:23 AM, Christian K=F6nig wrote:
>>> Something like the attached patch. Not even compile tested.
>>>
>>> Christian.
>>>
>>> Am 12.12.2017 um 20:13 schrieb Samuel Li:
>>>> Not sure if I understand your comments correctly. Currently amdgpu pri=
me reuses drm_gem_prime_dmabuf_ops{}, and it is defined as static which is =
reasonable. I do not see an easier way to introduce amdgpu_gem_begin_cpu_ac=
cess().
>>>>
>>>> Sam
>>>>
>>>> On 2017-12-12 01:30 PM, Christian K=F6nig wrote:
>>>>>> +    while (amdgpu_dmabuf_ops.begin_cpu_access !=3D amdgpu_gem_begin=
_cpu_access)
>>>>> I would rather just add the four liner code to drm to forward the beg=
in_cpu_access callback into a drm_driver callback instead of all this.
>>>>>
>>>>> But apart from that it looks good to me.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 12.12.2017 um 19:14 schrieb Li, Samuel:
>>>>>> A gentle ping on this one, Christian, can you take a look at this?
>>>>>>
>>>>>> Sam
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Li, Samuel
>>>>>> Sent: Friday, December 08, 2017 5:22 PM
>>>>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg>
>>>>>> Cc: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org<mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>>
>>>>>> Subject: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses =
dma buf.
>>>>>>
>>>>>> To improve cpu read performance. This is implemented for APUs curren=
tly.
>>>>>>
>>>>>> v2: Adapt to change https://lists.freedesktop.org/archives/amd-gfx/2=
017-October/015174.html
>>>>>>
>>>>>> Change-Id: I7a583e23a9ee706e0edd2a46f4e4186a609368e3
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  2 +-
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 58 +++++++++++++++++=
++++++++++++++
>>>>>>     3 files changed, 61 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu.h
>>>>>> index f8657c3..193db70 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -417,6 +417,8 @@ amdgpu_gem_prime_import_sg_table(struct drm_devi=
ce *dev,  struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>>>>>>                         struct drm_gem_object *gobj,
>>>>>>                         int flags);
>>>>>> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *d=
ev,
>>>>>> +                        struct dma_buf *dma_buf);
>>>>>>     int amdgpu_gem_prime_pin(struct drm_gem_object *obj);  void amdg=
pu_gem_prime_unpin(struct drm_gem_object *obj);  struct reservation_object =
*amdgpu_gem_prime_res_obj(struct drm_gem_object *); diff --git a/drivers/gp=
u/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index 31383e0..df30b08 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -868,7 +868,7 @@ static struct drm_driver kms_driver =3D {
>>>>>>         .prime_handle_to_fd =3D drm_gem_prime_handle_to_fd,
>>>>>>         .prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
>>>>>>         .gem_prime_export =3D amdgpu_gem_prime_export,
>>>>>> -    .gem_prime_import =3D drm_gem_prime_import,
>>>>>> +    .gem_prime_import =3D amdgpu_gem_prime_import,
>>>>>>         .gem_prime_pin =3D amdgpu_gem_prime_pin,
>>>>>>         .gem_prime_unpin =3D amdgpu_gem_prime_unpin,
>>>>>>         .gem_prime_res_obj =3D amdgpu_gem_prime_res_obj, diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_prime.c
>>>>>> index ae9c106..de6f599 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>     #include <drm/drmP.h>
>>>>>>       #include "amdgpu.h"
>>>>>> +#include "amdgpu_display.h"
>>>>>>     #include <drm/amdgpu_drm.h>
>>>>>>     #include <linux/dma-buf.h>
>>>>>>     @@ -164,6 +165,33 @@ struct reservation_object *amdgpu_gem_prime=
_res_obj(struct drm_gem_object *obj)
>>>>>>         return bo->tbo.resv;
>>>>>>     }
>>>>>>     +static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf,=
 enum
>>>>>> +dma_data_direction direction) {
>>>>>> +    struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(dma_buf->priv);
>>>>>> +    struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>>>>>> +    struct ttm_operation_ctx ctx =3D { true, false };
>>>>>> +    u32 domain =3D amdgpu_framebuffer_domains(adev);
>>>>>> +    long ret =3D 0;
>>>>>> +    bool reads =3D (direction =3D=3D DMA_BIDIRECTIONAL || direction=
 =3D=3D
>>>>>> +DMA_FROM_DEVICE);
>>>>>> +
>>>>>> +    if (!reads || !(domain | AMDGPU_GEM_DOMAIN_GTT) || bo->pin_coun=
t)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    /* move to gtt */
>>>>>> +    ret =3D amdgpu_bo_reserve(bo, false);
>>>>>> +    if (unlikely(ret !=3D 0))
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    amdgpu_ttm_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>>> +    ret =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>> +
>>>>>> +    amdgpu_bo_unreserve(bo);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static struct dma_buf_ops amdgpu_dmabuf_ops; static atomic_t aops_l=
ock;
>>>>>> +
>>>>>>     struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>>>>>>                         struct drm_gem_object *gobj,
>>>>>>                         int flags)
>>>>>> @@ -178,5 +206,35 @@ struct dma_buf *amdgpu_gem_prime_export(struct =
drm_device *dev,
>>>>>>         buf =3D drm_gem_prime_export(dev, gobj, flags);
>>>>>>         if (!IS_ERR(buf))
>>>>>>             buf->file->f_mapping =3D dev->anon_inode->i_mapping;
>>>>>> +
>>>>>> +    while (amdgpu_dmabuf_ops.begin_cpu_access !=3D amdgpu_gem_begin=
_cpu_access)
>>>>>> +    {
>>>>>> +        if (!atomic_cmpxchg(&aops_lock, 0, 1)) {
>>>>>> +            amdgpu_dmabuf_ops =3D *(buf->ops);
>>>>>> +            amdgpu_dmabuf_ops.begin_cpu_access =3D amdgpu_gem_begin=
_cpu_access;
>>>>>> +        }
>>>>>> +    }
>>>>>> +    buf->ops =3D &amdgpu_dmabuf_ops;
>>>>>> +
>>>>>>         return buf;
>>>>>>     }
>>>>>> +
>>>>>> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *d=
ev,
>>>>>> +                        struct dma_buf *dma_buf)
>>>>>> +{
>>>>>> +    struct drm_gem_object *obj;
>>>>>> +
>>>>>> +    if (dma_buf->ops =3D=3D &amdgpu_dmabuf_ops) {
>>>>>> +        obj =3D dma_buf->priv;
>>>>>> +        if (obj->dev =3D=3D dev) {
>>>>>> +            /*
>>>>>> +             * Importing dmabuf exported from out own gem increases
>>>>>> +             * refcount on gem itself instead of f_count of dmabuf.
>>>>>> +             */
>>>>>> +            drm_gem_object_get(obj);
>>>>>> +            return obj;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return drm_gem_prime_import(dev, dma_buf); }
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>

--_000_BLUPR12MB06283F027DB3101FEDFF46A0F5350BLUPR12MB0628namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">Will do after some basic testing.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">Sam<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander
<br>
<b>Sent:</b> Wednesday, December 13, 2017 2:49 PM<br>
<b>To:</b> Li, Samuel &lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Chri=
stian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu a=
ccesses dma buf.<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">P=
lease send the drm prime patch to dri-devel if you didn't already.<o:p></o:=
p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">A=
lex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Samuel Li &lt;<a href=3D"mailto:samuel.li-5C7GfCeVMHo@public.gmane.org">samuel.li@=
amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, December 13, 2017 2:17:49 PM<br>
<b>To:</b> Koenig, Christian; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu a=
ccesses dma buf.</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt">For the record.<br>
<br>
<br>
On 2017-12-13 01:26 PM, Christian K=F6nig wrote:<br>
&gt; Actually we try to avoid that drivers define their own dma_buf_ops in =
DRM.<br>
&gt; <br>
&gt; That's why you have all those callbacks in drm_driver which just mirro=
r the dma_buf interface but unpack the GEM object from the dma-buf object.<=
br>
&gt; <br>
&gt; There are quite a number of exceptions, but those drivers then impleme=
nt everything on their own because the DRM marshaling doesn't make sense fo=
r them.<br>
&gt; <br>
&gt; Christian.<br>
&gt; <br>
&gt; Am 13.12.2017 um 19:01 schrieb Samuel Li:<br>
&gt;&gt; That is an approach. The cost is to add a new call back, which is =
not necessary though, since driver can always actually define their own dma=
_buf_ops.<br>
&gt;&gt; The intention here is to allow a driver reuse drm_gem_prime_dmabuf=
_ops{}. If you would like to go this far, maybe a more straight forward way=
 is to export those ops, e.g. drm_gem_map_attach, so that a driver can use =
them in its own definitions.<br>
&gt;&gt;<br>
&gt;&gt; Sam<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 2017-12-13 05:23 AM, Christian K=F6nig wrote:<br>
&gt;&gt;&gt; Something like the attached patch. Not even compile tested.<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 12.12.2017 um 20:13 schrieb Samuel Li:<br>
&gt;&gt;&gt;&gt; Not sure if I understand your comments correctly. Currentl=
y amdgpu prime reuses drm_gem_prime_dmabuf_ops{}, and it is defined as stat=
ic which is reasonable. I do not see an easier way to introduce amdgpu_gem_=
begin_cpu_access().<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Sam<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 2017-12-12 01:30 PM, Christian K=F6nig wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; while (amdgpu_dmabuf_ops.b=
egin_cpu_access !=3D amdgpu_gem_begin_cpu_access)<br>
&gt;&gt;&gt;&gt;&gt; I would rather just add the four liner code to drm to =
forward the begin_cpu_access callback into a drm_driver callback instead of=
 all this.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; But apart from that it looks good to me.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Am 12.12.2017 um 19:14 schrieb Li, Samuel:<br>
&gt;&gt;&gt;&gt;&gt;&gt; A gentle ping on this one, Christian, can you take=
 a look at this?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Sam<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt;&gt;&gt;&gt;&gt;&gt; From: Li, Samuel<br>
&gt;&gt;&gt;&gt;&gt;&gt; Sent: Friday, December 08, 2017 5:22 PM<br>
&gt;&gt;&gt;&gt;&gt;&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Li, Samuel &lt;<a href=3D"mailto:Samuel.Li@amd=
.com">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH v2 2/2] drm/amdgpu: Move to gtt be=
fore cpu accesses dma buf.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; To improve cpu read performance. This is implement=
ed for APUs currently.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; v2: Adapt to change <a href=3D"https://lists.freed=
esktop.org/archives/amd-gfx/2017-October/015174.html">
https://lists.freedesktop.org/archives/amd-gfx/2017-October/015174.html</a>=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Change-Id: I7a583e23a9ee706e0edd2a46f4e4186a609368=
e3<br>
&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdg=
pu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;&#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdg=
pu_drv.c&nbsp;&nbsp; |&nbsp; 2 &#43;-<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdg=
pu_prime.c | 58 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; 3 files changed, 61 insertions(=
&#43;), 1 deletion(-)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b=
/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt;&gt;&gt;&gt; index f8657c3..193db70 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgp=
u.h<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -417,6 &#43;417,8 @@ amdgpu_gem_prime_import_sg=
_table(struct drm_device *dev,&nbsp; struct dma_buf *amdgpu_gem_prime_expor=
t(struct drm_device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct drm_gem_object *gobj,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; int flags);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;struct drm_gem_object *amdgpu_gem_prime_impor=
t(struct drm_device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; int amdgpu_gem_prime_pin(struct=
 drm_gem_object *obj);&nbsp; void amdgpu_gem_prime_unpin(struct drm_gem_obj=
ect *obj);&nbsp; struct reservation_object *amdgpu_gem_prime_res_obj(struct=
 drm_gem_object *); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/=
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; index 31383e0..df30b08 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_drv.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -868,7 &#43;868,7 @@ static struct drm_driver k=
ms_driver =3D {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prime_=
handle_to_fd =3D drm_gem_prime_handle_to_fd,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prime_=
fd_to_handle =3D drm_gem_prime_fd_to_handle,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_pr=
ime_export =3D amdgpu_gem_prime_export,<br>
&gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; .gem_prime_import =3D drm_gem_=
prime_import,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; .gem_prime_import =3D amdg=
pu_gem_prime_import,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_pr=
ime_pin =3D amdgpu_gem_prime_pin,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_pr=
ime_unpin =3D amdgpu_gem_prime_unpin,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_pr=
ime_res_obj =3D amdgpu_gem_prime_res_obj, diff --git a/drivers/gpu/drm/amd/=
amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; index ae9c106..de6f599 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_prime.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -26,6 &#43;26,7 @@<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; #include &lt;drm/drmP.h&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; &nbsp; #include &quot;amdgpu.h&=
quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;#include &quot;amdgpu_display.h&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; #include &lt;drm/amdgpu_drm.h&g=
t;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; #include &lt;linux/dma-buf.h&gt=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; @@ -164,6 &#43;165,33 @@ struct=
 reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
bo-&gt;tbo.resv;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; &#43;static int amdgpu_gem_begi=
n_cpu_access(struct dma_buf *dma_buf, enum<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;dma_data_direction direction) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D g=
em_to_amdgpu_bo(dma_buf-&gt;priv);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx c=
tx =3D { true, false };<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; u32 domain =3D amdgpu_fram=
ebuffer_domains(adev);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; long ret =3D 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; bool reads =3D (direction =
=3D=3D DMA_BIDIRECTIONAL || direction =3D=3D<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;DMA_FROM_DEVICE);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (!reads || !(domain | A=
MDGPU_GEM_DOMAIN_GTT) || bo-&gt;pin_count)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; /* move to gtt */<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(=
bo, false);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (unlikely(ret !=3D 0))<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn ret;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; amdgpu_ttm_placement_from_=
domain(bo, AMDGPU_GEM_DOMAIN_GTT);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; ret =3D ttm_bo_validate(&a=
mp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;static struct dma_buf_ops amdgpu_dmabuf_ops; =
static atomic_t aops_lock;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; struct dma_buf *amdgpu_gem_prim=
e_export(struct drm_device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct drm_gem_object *gobj,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; int flags)<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -178,5 &#43;206,35 @@ struct dma_buf *amdgpu_ge=
m_prime_export(struct drm_device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf =3D=
 drm_gem_prime_export(dev, gobj, flags);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS=
_ERR(buf))<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; buf-&gt;file-&gt;f_mapping =3D dev-&gt;anon_inode-&gt;i_ma=
pping;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; while (amdgpu_dmabuf_ops.b=
egin_cpu_access !=3D amdgpu_gem_begin_cpu_access)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (!atomic_cmpxchg(&amp;aops_lock, 0, 1)) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dmabuf_ops =3D *(buf-&gt;ops);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dmabuf_ops.begin_cpu_access =3D amdgpu_gem_beg=
in_cpu_access;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; buf-&gt;ops =3D &amp;amdgp=
u_dmabuf_ops;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
buf;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;struct drm_gem_object *amdgpu_gem_prime_impor=
t(struct drm_device *dev,<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf)<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops =3D=3D=
 &amp;amdgpu_dmabuf_ops) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ob=
j =3D dma_buf-&gt;priv;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (obj-&gt;dev =3D=3D dev) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * Importing dmabuf exported from out own gem in=
creases<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * refcount on gem itself instead of f_count of =
dmabuf.<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_gem_object_get(obj);<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return obj;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp; return drm_gem_prime_impor=
t(dev, dma_buf); }<br>
&gt;&gt;&gt;&gt;&gt;&gt; --&nbsp;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2.7.4<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; <o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BLUPR12MB06283F027DB3101FEDFF46A0F5350BLUPR12MB0628namp_--

--===============0174282710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0174282710==--

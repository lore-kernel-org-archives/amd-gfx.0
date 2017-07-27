From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add support for filling a buffer with 64
 bit value
Date: Thu, 27 Jul 2017 15:51:00 +0000
Message-ID: <CY1PR1201MB1097B1E4DEED6547D9AFB370F0BE0@CY1PR1201MB1097.namprd12.prod.outlook.com>
References: <1501101911-22711-1-git-send-email-Yong.Zhao@amd.com>
 <bab2f91a-553b-0030-a8ee-13e488810eb4@vodafone.de>
 <CY1PR1201MB1097EB9BD9F52DFD48249814F0BE0@CY1PR1201MB1097.namprd12.prod.outlook.com>,
 <643b3543-7d55-a02c-b034-51ed9267b5ac@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0173218624=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <643b3543-7d55-a02c-b034-51ed9267b5ac-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, =?Windows-1252?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0173218624==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR1201MB1097B1E4DEED6547D9AFB370F0BE0CY1PR1201MB1097_"

--_000_CY1PR1201MB1097B1E4DEED6547D9AFB370F0BE0CY1PR1201MB1097_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I got it. Thanks Harry.


Yong

________________________________
From: Wentland, Harry
Sent: Thursday, July 27, 2017 11:48:13 AM
To: Zhao, Yong; Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amdgpu: Add support for filling a buffer with =
64 bit value

On 2017-07-27 11:44 AM, Zhao, Yong wrote:
> Hi Christian,
>
>
> I used eclipse. The reason why I changed the indent is that the current
> indents are composed of tabs and spaces, and I will get style warning
> from checkpatch script when trying to submit it to gerrit, so I made the
> indents all tabs. In this case, should I still use the previous indents?
>

Generally it's not a good idea to combine style fixes with functional
changes as it makes it hard to spot the functional change. It's better
to ignore warnings in that case if they're not in the same line you modify.

Harry

>
> Regards,
>
> Yong
>
>
>
> ------------------------------------------------------------------------
> *From:* Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Thursday, July 27, 2017 5:34:58 AM
> *To:* Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Add support for filling a buffer
> with 64 bit value
>
> Am 26.07.2017 um 22:45 schrieb Yong Zhao:
>> That function will be used later to support setting a page table
>> block with 64 bit value.
>>
>> Change-Id: Ib142ebd4163d6e23670a3f0ceed536d59133b942
>> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 +++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  2 +-
>>   2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ttm.c
>> index 4d2a454..6ab30da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1509,11 +1509,12 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring,=
 uint64_t src_offset,
>>   }
>>
>>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>> -                    uint32_t src_data,
>> -                    struct reservation_object *resv,
>> -                    struct dma_fence **fence)
>> +                     uint64_t src_data,
>> +                     struct reservation_object *resv,
>> +                     struct dma_fence **fence)
>
> Looks like you accidentally changed the indentation of the other
> function parameters here. What editor do you use?
>
> Please make sure that you only change the type, with that fixed the
> patch is Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Regards,
> Christian.
>
>>   {
>>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>> +     /* max_bytes applies to SDMA_OP_PTEPDE as well as SDMA_OP_CONST_FI=
LL*/
>>        uint32_t max_bytes =3D adev->mman.buffer_funcs->fill_max_bytes;
>>        struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
>>
>> @@ -1545,7 +1546,9 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>                num_pages -=3D mm_node->size;
>>                ++mm_node;
>>        }
>> -     num_dw =3D num_loops * adev->mman.buffer_funcs->fill_num_dw;
>> +
>> +     /* 10 double words for each SDMA_OP_PTEPDE cmd */
>> +     num_dw =3D num_loops * 10;
>>
>>        /* for IB padding */
>>        num_dw +=3D 64;
>> @@ -1570,12 +1573,16 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>                uint32_t byte_count =3D mm_node->size << PAGE_SHIFT;
>>                uint64_t dst_addr;
>>
>> +             WARN_ONCE(byte_count & 0x7, "size should be a multiple of =
8");
>> +
>>                dst_addr =3D amdgpu_mm_node_addr(&bo->tbo, mm_node, &bo->=
tbo.mem);
>>                while (byte_count) {
>>                        uint32_t cur_size_in_bytes =3D min(byte_count, ma=
x_bytes);
>>
>> -                     amdgpu_emit_fill_buffer(adev, &job->ibs[0], src_da=
ta,
>> -                                             dst_addr, cur_size_in_byte=
s);
>> +                     amdgpu_vm_set_pte_pde(adev, &job->ibs[0],
>> +                                     dst_addr, 0,
>> +                                     cur_size_in_bytes >> 3, 0,
>> +                                     src_data);
>>
>>                        dst_addr +=3D cur_size_in_bytes;
>>                        byte_count -=3D cur_size_in_bytes;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ttm.h
>> index f137c24..0e2399f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -73,7 +73,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint6=
4_t src_offset,
>>                       struct dma_fence **fence, bool direct_submit,
>>                       bool vm_needs_flush);
>>   int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>> -                     uint32_t src_data,
>> +                     uint64_t src_data,
>>                        struct reservation_object *resv,
>>                        struct dma_fence **fence);
>>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--_000_CY1PR1201MB1097B1E4DEED6547D9AFB370F0BE0CY1PR1201MB1097_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
<p>I got it. Thanks Harry.&nbsp;</p>
<p><br>
</p>
<p>Yong<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Thursday, July 27, 2017 11:48:13 AM<br>
<b>To:</b> Zhao, Yong; Christian K=F6nig; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Add support for filling a buffe=
r with 64 bit value</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 2017-07-27 11:44 AM, Zhao, Yong wrote:<br>
&gt; Hi Christian,<br>
&gt; <br>
&gt; <br>
&gt; I used eclipse. The reason why I changed the indent is that the curren=
t<br>
&gt; indents are composed of tabs and spaces, and I will get style warning<=
br>
&gt; from checkpatch script when trying to submit it to gerrit, so I made t=
he<br>
&gt; indents all tabs. In this case, should I still use the previous indent=
s?<br>
&gt; <br>
<br>
Generally it's not a good idea to combine style fixes with functional<br>
changes as it makes it hard to spot the functional change. It's better<br>
to ignore warnings in that case if they're not in the same line you modify.=
<br>
<br>
Harry<br>
<br>
&gt; <br>
&gt; Regards,<br>
&gt; <br>
&gt; Yong<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Christian K=F6nig &lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
&gt; *Sent:* Thursday, July 27, 2017 5:34:58 AM<br>
&gt; *To:* Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; *Subject:* Re: [PATCH 1/2] drm/amdgpu: Add support for filling a buffe=
r<br>
&gt; with 64 bit value<br>
&gt;&nbsp; <br>
&gt; Am 26.07.2017 um 22:45 schrieb Yong Zhao:<br>
&gt;&gt; That function will be used later to support setting a page table<b=
r>
&gt;&gt; block with 64 bit value.<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: Ib142ebd4163d6e23670a3f0ceed536d59133b942<br>
&gt;&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 19 &#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |&nbsp; 2 &#43=
;-<br>
&gt;&gt;&nbsp;&nbsp; 2 files changed, 14 insertions(&#43;), 7 deletions(-)<=
br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt; index 4d2a454..6ab30da 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt; @@ -1509,11 &#43;1509,12 @@ int amdgpu_copy_buffer(struct amdgpu_r=
ing *ring, uint64_t src_offset,<br>
&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_fill_buffer(struct amdgpu_bo *bo,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t src_data,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct reservation_object=
 *resv,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)=
<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t src_da=
ta,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct reservat=
ion_object *resv,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fenc=
e **fence)<br>
&gt; <br>
&gt; Looks like you accidentally changed the indentation of the other<br>
&gt; function parameters here. What editor do you use?<br>
&gt; <br>
&gt; Please make sure that you only change the type, with that fixed the<br=
>
&gt; patch is Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&g=
t;.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt; <br>
&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *ad=
ev =3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* max_bytes applies to SDMA_OP_PTEP=
DE as well as SDMA_OP_CONST_FILL*/<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_bytes =3D a=
dev-&gt;mman.buffer_funcs-&gt;fill_max_bytes;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring=
 =3D adev-&gt;mman.buffer_funcs_ring;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; @@ -1545,7 &#43;1546,9 @@ int amdgpu_fill_buffer(struct amdgpu_bo =
*bo,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; num_pages -=3D mm_node-&gt;size;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &#43;&#43;mm_node;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; num_dw =3D num_loops * adev-&gt;mman.buf=
fer_funcs-&gt;fill_num_dw;<br>
&gt;&gt; &#43;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* 10 double words for each SDMA_OP_=
PTEPDE cmd */<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; num_dw =3D num_loops * 10;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for IB padding */<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dw &#43;=3D 64;<br>
&gt;&gt; @@ -1570,12 &#43;1573,16 @@ int amdgpu_fill_buffer(struct amdgpu_b=
o *bo,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; uint32_t byte_count =3D mm_node-&gt;size &lt;&lt; P=
AGE_SHIFT;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst_addr;<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; WARN_ONCE(byte_count &amp; 0x7, &quot;size should be a multiple=
 of 8&quot;);<br>
&gt;&gt; &#43;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; dst_addr =3D amdgpu_mm_node_addr(&amp;bo-&gt;tbo, m=
m_node, &amp;bo-&gt;tbo.mem);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; while (byte_count) {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uin=
t32_t cur_size_in_bytes =3D min(byte_count, max_bytes);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_emit_fill_bu=
ffer(adev, &amp;job-&gt;ibs[0], src_data,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_addr, cur_size_in_byt=
es);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_set_p=
te_pde(adev, &amp;job-&gt;ibs[0],<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; dst_addr, 0,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; cur_size_in_bytes &gt;&gt; 3, 0,<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; src_data);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst=
_addr &#43;=3D cur_size_in_bytes;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; byt=
e_count -=3D cur_size_in_bytes;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt; index f137c24..0e2399f 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h<br>
&gt;&gt; @@ -73,7 &#43;73,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *r=
ing, uint64_t src_offset,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm=
a_fence **fence, bool direct_submit,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_n=
eeds_flush);<br>
&gt;&gt;&nbsp;&nbsp; int amdgpu_fill_buffer(struct amdgpu_bo *bo,<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t src_data,<=
br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t src_da=
ta,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct reservation_object *resv,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str=
uct dma_fence **fence);<br>
&gt;&gt;&nbsp;&nbsp; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; <br>
</div>
</span></font>
</body>
</html>

--_000_CY1PR1201MB1097B1E4DEED6547D9AFB370F0BE0CY1PR1201MB1097_--

--===============0173218624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0173218624==--

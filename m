From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Random short freezes due to TTM buffer migrations
Date: Thu, 18 Aug 2016 01:39:09 +0200
Message-ID: <CAAxE2A4P7WHQ-1_rh7Gh4X+Go-7eXWEHd=XcQCkMszwN=ea+sQ@mail.gmail.com>
References: <CAAxE2A4uM2UqKk8NpZ5fi9oAgPKzGiwyuZ1Kp22ok+pz1BghLA@mail.gmail.com>
 <ea56e120-48bc-2dee-0868-2e79b5c30b09@vodafone.de>
 <8e40d3b9-0df9-81b2-dad2-ae7a8e757f06@amd.com>
 <f983530a-8a92-c748-cab1-d498f54f05ab@vodafone.de>
 <d5f70a4f-0f3a-effe-d539-da3c2481c55d@amd.com>
 <78533e4b-44c5-c2f1-2e68-7c2ae5f427ac@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1568246122=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <78533e4b-44c5-c2f1-2e68-7c2ae5f427ac-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1568246122==
Content-Type: multipart/alternative; boundary=001a113d0e4e3660bc053a4cfb04

--001a113d0e4e3660bc053a4cfb04
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Actually, I was wrong.

The buffers in that app are pretty small. The largest one has 86 MB and
others have 52 MB. I must have misread that as 520 MB.

At one point, ttm_bo_validate with a 32 MB buffer moved 971 MB.

Maybe it's just a VRAM fragmentation issue (i.e. a lack of contiguous free
memory).

Marek

On Wed, Aug 17, 2016 at 9:19 PM, Christian K=C3=B6nig <deathsimple@vodafone=
.de>
wrote:

> Sharing buffers between applications is handled by the DRM layer and
> transparent to the driver.
>
> E.g. the driver is not even informed if a sharing is done by DMA-buf or
> GEM flink, it's just another reference to the BO.
>
> So there isn't any change to that at all.
>
> Regards,
> Christian.
>
>
> Am 17.08.2016 um 21:03 schrieb Felix Kuehling:
>
>> I think the scatter-gather tables only support system memory. As I
>> understand it, a buffer in VRAM has be migrated to system memory before
>> it can be shared with another driver.
>>
>> I'm more concerned about sharing with the same driver. There is a
>> special code path for that, where we simply add another reference to the
>> same BO, instead of looking at a scatter gather table. We use that for
>> OpenGL-OpenCL interop, and also planning to use it for IPC buffer
>> sharing in HSA. As long as a split VRAM buffer is still a single
>> amdgpu_bo, and becomes a single dmabuf when exporting it, I think that
>> should work.
>>
>> Regards,
>>    Felix
>>
>>
>> On 16-08-17 02:58 AM, Christian K=C3=B6nig wrote:
>>
>>> One question: Will it be possible to share these split BOs as dmabufs?
>>>>
>>> In theory yes, in practice I'm not sure.
>>>
>>> DMA-bufs are designed around scatter gather tables, those fortunately
>>> support buffers split over the whole address space.
>>>
>>> The problem is the importing device needs to be able to handle that as
>>> well.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 16.08.2016 um 20:33 schrieb Felix Kuehling:
>>>
>>>> Very nice. I'm looking forward to this for KFD as well.
>>>>
>>>> One question: Will it be possible to share these split BOs as dmabufs?
>>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>> On 16-08-16 11:27 AM, Christian K=C3=B6nig wrote:
>>>>
>>>>> Hi Marek,
>>>>>
>>>>> I'm already working on this.
>>>>>
>>>>> My current approach is to use a custom BO manager for VRAM with TTM
>>>>> and so split allocations into chunks of 4MB.
>>>>>
>>>>> Large BOs are still swapped out as one, but it makes it much more
>>>>> likely to that you can allocate 1/2 of VRAM as one buffer.
>>>>>
>>>>> Give me till the end of the week to finish this and then we can test
>>>>> if that's sufficient or if we need to do more.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 16.08.2016 um 16:33 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I'm seeing random temporary freezes (up to 2 seconds) under memory
>>>>>> pressure. Before I describe the exact circumstances, I'd like to say
>>>>>> that this is a serious issue affecting playability of certain AAA
>>>>>> Linux games.
>>>>>>
>>>>>> In order to reproduce this, an application should:
>>>>>> - allocate a few very large buffers (256-512 MB per buffer)
>>>>>> - allocate more memory than there is available VRAM. The issue also
>>>>>> occurs (but at a lower frequency) if the app needs only 80% of VRAM.
>>>>>>
>>>>>> Example: ttm_bo_validate needs to migrate a 512 MB buffer. The total
>>>>>> size of moved memory for that call can be as high as 1.5 GB. This is
>>>>>> always followed by a big temporary drop in VRAM usage.
>>>>>>
>>>>>> The game I'm testing needs 3.4 GB of VRAM.
>>>>>>
>>>>>> Setups:
>>>>>> Tonga - 2 GB: It's nearly unplayable, because freezes occur too ofte=
n.
>>>>>> Fiji - 4 GB: There is one freeze at the beginning (which is annoying
>>>>>> too), after that it's smooth.
>>>>>>
>>>>>> So even 4 GB is not enough.
>>>>>>
>>>>>> Workarounds:
>>>>>> - Split buffers into smaller pieces in the kernel. It's not necessar=
y
>>>>>> to manage memory at page granularity (64KB). Splitting buffers into
>>>>>> 16MB-large pieces might not be optimal but it would be a significant
>>>>>> improvement.
>>>>>> - Or do the same in Mesa. This would prevent inter-process and
>>>>>> inter-API buffer sharing for split buffers (DRI, OpenCL), but we wou=
ld
>>>>>> at least verify how much the situation improves.
>>>>>>
>>>>>> Other issues sharing the same cause:
>>>>>> - Allocations requesting 1/3 or more VRAM have a high chance of
>>>>>> failing. It's generally not possible to allocate 1/2 or more VRAM as
>>>>>> one buffer.
>>>>>>
>>>>>> Comments welcome,
>>>>>>
>>>>>> Marek
>>>>>> _______________________________________________
>>>>>> amd-gfx mailing list
>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>
>>>>
>>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>
>

--001a113d0e4e3660bc053a4cfb04
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Actually, I was wrong.<br><br></div>The buffers =
in that app are pretty small. The largest one has 86 MB and others have 52 =
MB. I must have misread that as 520 MB.<br><br></div><div>At one point, ttm=
_bo_validate with a 32 MB buffer moved 971 MB.<br><br></div><div>Maybe it&#=
39;s just a VRAM fragmentation issue (i.e. a lack of  contiguous free memor=
y).</div><div><br></div>Marek<br><div><div><div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Wed, Aug 17, 2016 at 9:19 PM, Christian K=
=C3=B6nig <span dir=3D"ltr">&lt;<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" =
target=3D"_blank">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Sharing buffers between applicati=
ons is handled by the DRM layer and transparent to the driver.<br>
<br>
E.g. the driver is not even informed if a sharing is done by DMA-buf or GEM=
 flink, it&#39;s just another reference to the BO.<br>
<br>
So there isn&#39;t any change to that at all.<br>
<br>
Regards,<br>
Christian.<div class=3D""><div class=3D"h5"><br>
<br>
Am 17.08.2016 um 21:03 schrieb Felix Kuehling:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I think the scatter-gather tables only support system memory. As I<br>
understand it, a buffer in VRAM has be migrated to system memory before<br>
it can be shared with another driver.<br>
<br>
I&#39;m more concerned about sharing with the same driver. There is a<br>
special code path for that, where we simply add another reference to the<br=
>
same BO, instead of looking at a scatter gather table. We use that for<br>
OpenGL-OpenCL interop, and also planning to use it for IPC buffer<br>
sharing in HSA. As long as a split VRAM buffer is still a single<br>
amdgpu_bo, and becomes a single dmabuf when exporting it, I think that<br>
should work.<br>
<br>
Regards,<br>
=C2=A0 =C2=A0Felix<br>
<br>
<br>
On 16-08-17 02:58 AM, Christian K=C3=B6nig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
One question: Will it be possible to share these split BOs as dmabufs?<br>
</blockquote>
In theory yes, in practice I&#39;m not sure.<br>
<br>
DMA-bufs are designed around scatter gather tables, those fortunately<br>
support buffers split over the whole address space.<br>
<br>
The problem is the importing device needs to be able to handle that as<br>
well.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 16.08.2016 um 20:33 schrieb Felix Kuehling:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Very nice. I&#39;m looking forward to this for KFD as well.<br>
<br>
One question: Will it be possible to share these split BOs as dmabufs?<br>
<br>
Regards,<br>
=C2=A0 =C2=A0 Felix<br>
<br>
<br>
On 16-08-16 11:27 AM, Christian K=C3=B6nig wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Hi Marek,<br>
<br>
I&#39;m already working on this.<br>
<br>
My current approach is to use a custom BO manager for VRAM with TTM<br>
and so split allocations into chunks of 4MB.<br>
<br>
Large BOs are still swapped out as one, but it makes it much more<br>
likely to that you can allocate 1/2 of VRAM as one buffer.<br>
<br>
Give me till the end of the week to finish this and then we can test<br>
if that&#39;s sufficient or if we need to do more.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 16.08.2016 um 16:33 schrieb Marek Ol=C5=A1=C3=A1k:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Hi,<br>
<br>
I&#39;m seeing random temporary freezes (up to 2 seconds) under memory<br>
pressure. Before I describe the exact circumstances, I&#39;d like to say<br=
>
that this is a serious issue affecting playability of certain AAA<br>
Linux games.<br>
<br>
In order to reproduce this, an application should:<br>
- allocate a few very large buffers (256-512 MB per buffer)<br>
- allocate more memory than there is available VRAM. The issue also<br>
occurs (but at a lower frequency) if the app needs only 80% of VRAM.<br>
<br>
Example: ttm_bo_validate needs to migrate a 512 MB buffer. The total<br>
size of moved memory for that call can be as high as 1.5 GB. This is<br>
always followed by a big temporary drop in VRAM usage.<br>
<br>
The game I&#39;m testing needs 3.4 GB of VRAM.<br>
<br>
Setups:<br>
Tonga - 2 GB: It&#39;s nearly unplayable, because freezes occur too often.<=
br>
Fiji - 4 GB: There is one freeze at the beginning (which is annoying<br>
too), after that it&#39;s smooth.<br>
<br>
So even 4 GB is not enough.<br>
<br>
Workarounds:<br>
- Split buffers into smaller pieces in the kernel. It&#39;s not necessary<b=
r>
to manage memory at page granularity (64KB). Splitting buffers into<br>
16MB-large pieces might not be optimal but it would be a significant<br>
improvement.<br>
- Or do the same in Mesa. This would prevent inter-process and<br>
inter-API buffer sharing for split buffers (DRI, OpenCL), but we would<br>
at least verify how much the situation improves.<br>
<br>
Other issues sharing the same cause:<br>
- Allocations requesting 1/3 or more VRAM have a high chance of<br>
failing. It&#39;s generally not possible to allocate 1/2 or more VRAM as<br=
>
one buffer.<br>
<br>
Comments welcome,<br>
<br>
Marek<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></blockquote>
<br>
</blockquote>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote>
<br>
<br>
</div></div></blockquote></div><br></div></div></div></div></div>

--001a113d0e4e3660bc053a4cfb04--

--===============1568246122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1568246122==--

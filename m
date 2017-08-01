From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add tracepoint for DMA page mapping
Date: Tue, 1 Aug 2017 15:56:25 +0000
Message-ID: <DM5PR12MB12572F535B64B97DF2C93C6EF2B30@DM5PR12MB1257.namprd12.prod.outlook.com>
References: <20170801115131.27610-1-tom.stdenis@amd.com>
 <b4945fed-aea3-1b15-b383-26bc65307139@vodafone.de>
 <21a75bbf-e9ca-e9e9-5831-e58908911e9b@amd.com>
 <56a6ecd5-d210-cd71-0fc0-2d0ffd36ab00@vodafone.de>
 <29f09f3b-154d-70d2-f5c6-315022b408ea@amd.com>
 <67a7f3ec-fd54-e997-75a0-4d6e3d2ff908@vodafone.de>
 <ae6e3523-dd8e-a14e-9bb2-297b0114bd5e@amd.com>,
 <b38d7cac-533d-7029-f73f-445a92d6b952@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0297844164=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b38d7cac-533d-7029-f73f-445a92d6b952-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0297844164==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB12572F535B64B97DF2C93C6EF2B30DM5PR12MB1257namp_"

--_000_DM5PR12MB12572F535B64B97DF2C93C6EF2B30DM5PR12MB1257namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I don't know if compiler is smart enough to optimize the following for stat=
ement out...


+               for (i =3D 0; i < ttm->num_pages; i++) {
+                       trace_amdgpu_ttm_tt_populate(
+                               adev,
+                               gtt->ttm.dma_address[i],
+                               page_to_phys(ttm->pages[i]));
+               }


-Alex Bin

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Tuesday, August 1, 2017 11:41 AM
To: Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/amdgpu: Add tracepoint for DMA page mapping

We can turn of the trace subsystem during compile time already.

Additional to that the trace points use self modifying code to make sure
that they don't have any overhead as long as they are turned off. But I
don't think this works with the "if (trace_*_enabled()" as well.

Anyway, not a performance critical code path so I don't really bother.

Christian.

Am 01.08.2017 um 17:00 schrieb axie:
> Because this is used by a debug tool, can we use a macro to
> conditionally compile this feature?
>
>
> On 2017-08-01 10:54 AM, Christian K=F6nig wrote:
>> Am 01.08.2017 um 16:26 schrieb Tom St Denis:
>>> On 01/08/17 10:10 AM, Christian K=F6nig wrote:
>>>
>>>> You need to cover multiple code path here:
>>>> 1. The one you currently implemented which uses ttm_dma_populate()
>>>> and pci_map_page().
>>>> 2. The one using ttm_dma_populate().
>>>
>>> I'll have to look into this one though it's my understanding that
>>> code path is only followed if there's no (hardware) IOMMU right?
>>
>> Wrong, that one is used when "anything" in the system used the
>> SWIOTLB path once. So the detection doesn't always work reliable.
>>
>>> This one seems rather straight forward but the only catch is I don't
>>> have access to "adev" inside that drm function.
>>
>> When you have a ttm you can always do "amdgpu_ttm_adev(ttm->bdev)" to
>> get the adev.
>>
>>>   Would it be taboo to do something like
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 376078334f54..cd97ef2144c9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -916,6 +916,12 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt
>>> *ttm)
>>>                 drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
>>> gtt->ttm.dma_address, ttm->num_pages);
>>>                 ttm->state =3D tt_unbound;
>>> +               for (i =3D 0; i < ttm->num_pages; i++) {
>>> +                       trace_amdgpu_ttm_tt_populate(
>>> +                               adev,
>>> +                               gtt->ttm.dma_address[i],
>>> + page_to_phys(ttm->pages[i]));
>>> +               }
>>>                 return 0;
>>>         }
>>>
>>> This would normally result in a for loop around a nop which
>>> shouldn't be a huge performance hit but is one none the less.
>>
>> Try using trace_trace_amdgpu_ttm_tt_populate_enabled(), those
>> functions are generated by the trace subsystem automatically when you
>> define a trace point.
>>
>> It just doesn't use those nice tricks to modify the compiled binary
>> on the fly.
>>
>> Christian.
>>
>>>
>>>> 4. The in amdgpu_ttm_tt_pin_userptr() which uses dma_map_sg() for
>>>> userptrs.
>>>>
>>>> Basically all just take gtt->ttm.ttm.pages and fill
>>>> gtt->ttm.dma_address.
>>>
>>> Same comment as #3.  I can tackle this with a for loop around the
>>> trace if that is ok.
>>>
>>>> I suggest to add a helper you can call to trace all
>>>> pages->dma_address mappings inside a ttm.
>>>
>>> One thing at a time :-).  That would probably be a bit better since
>>> the trace log gets filled with remappings (which is why my
>>> proof-of-concept umr patch only grabs the latest mapping as it reads
>>> the trace).
>>>
>>> Is there a handy place we can grab a list of ttm_tt's bound to our
>>> device?  If so then in theory I could write a debugfs interface
>>> instead.
>>>
>>> Thanks for your patience as I'm definitely less familiar with the VM
>>> side of things :-)
>>>
>>> Cheers,
>>> Tom
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...


>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...


>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...





--_000_DM5PR12MB12572F535B64B97DF2C93C6EF2B30DM5PR12MB1257namp_
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
<p>I don't know if compiler is smart enough to optimize the following for s=
tatement out...</p>
<p><br>
</p>
<p><font size=3D"2"><span style=3D"font-size:10pt;">&#43;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =
=3D 0; i &lt; ttm-&gt;num_pages; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu=
_ttm_tt_populate(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;ttm.dma_address[i],<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page_to_phys(ttm-&gt;pages[i]));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }</span></font></p>
<br>
<p>-Alex Bin<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Christian K=F6nig &=
lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, August 1, 2017 11:41 AM<br>
<b>To:</b> Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add tracepoint for DMA page map=
ping</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">We can turn of the trace subsystem during compile =
time already.<br>
<br>
Additional to that the trace points use self modifying code to make sure <b=
r>
that they don't have any overhead as long as they are turned off. But I <br=
>
don't think this works with the &quot;if (trace_*_enabled()&quot; as well.<=
br>
<br>
Anyway, not a performance critical code path so I don't really bother.<br>
<br>
Christian.<br>
<br>
Am 01.08.2017 um 17:00 schrieb axie:<br>
&gt; Because this is used by a debug tool, can we use a macro to <br>
&gt; conditionally compile this feature?<br>
&gt;<br>
&gt;<br>
&gt; On 2017-08-01 10:54 AM, Christian K=F6nig wrote:<br>
&gt;&gt; Am 01.08.2017 um 16:26 schrieb Tom St Denis:<br>
&gt;&gt;&gt; On 01/08/17 10:10 AM, Christian K=F6nig wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; You need to cover multiple code path here:<br>
&gt;&gt;&gt;&gt; 1. The one you currently implemented which uses ttm_dma_po=
pulate() <br>
&gt;&gt;&gt;&gt; and pci_map_page().<br>
&gt;&gt;&gt;&gt; 2. The one using ttm_dma_populate().<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I'll have to look into this one though it's my understanding t=
hat <br>
&gt;&gt;&gt; code path is only followed if there's no (hardware) IOMMU righ=
t?<br>
&gt;&gt;<br>
&gt;&gt; Wrong, that one is used when &quot;anything&quot; in the system us=
ed the <br>
&gt;&gt; SWIOTLB path once. So the detection doesn't always work reliable.<=
br>
&gt;&gt;<br>
&gt;&gt;&gt; This one seems rather straight forward but the only catch is I=
 don't <br>
&gt;&gt;&gt; have access to &quot;adev&quot; inside that drm function.<br>
&gt;&gt;<br>
&gt;&gt; When you have a ttm you can always do &quot;amdgpu_ttm_adev(ttm-&g=
t;bdev)&quot; to <br>
&gt;&gt; get the adev.<br>
&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp; Would it be taboo to do something like<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c <br>
&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt; index 376078334f54..cd97ef2144c9 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt; @@ -916,6 &#43;916,12 @@ static int amdgpu_ttm_tt_populate(str=
uct ttm_tt <br>
&gt;&gt;&gt; *ttm)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_prime_sg_to_page_addr_arrays(ttm-&gt;=
sg, ttm-&gt;pages,<br>
&gt;&gt;&gt; gtt-&gt;ttm.dma_address, ttm-&gt;num_pages);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm-&gt;state =3D tt_unbound;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ttm-&gt;num_pages; i&#43;&=
#43;) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 trace_amdgpu_ttm_tt_populate(<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;ttm.dma_address[i]=
,<br>
&gt;&gt;&gt; &#43; page_to_phys(ttm-&gt;pages[i]));<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This would normally result in a for loop around a nop which <b=
r>
&gt;&gt;&gt; shouldn't be a huge performance hit but is one none the less.<=
br>
&gt;&gt;<br>
&gt;&gt; Try using trace_trace_amdgpu_ttm_tt_populate_enabled(), those <br>
&gt;&gt; functions are generated by the trace subsystem automatically when =
you <br>
&gt;&gt; define a trace point.<br>
&gt;&gt;<br>
&gt;&gt; It just doesn't use those nice tricks to modify the compiled binar=
y <br>
&gt;&gt; on the fly.<br>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 4. The in amdgpu_ttm_tt_pin_userptr() which uses dma_map_s=
g() for <br>
&gt;&gt;&gt;&gt; userptrs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Basically all just take gtt-&gt;ttm.ttm.pages and fill <br=
>
&gt;&gt;&gt;&gt; gtt-&gt;ttm.dma_address.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Same comment as #3.&nbsp; I can tackle this with a for loop ar=
ound the <br>
&gt;&gt;&gt; trace if that is ok.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I suggest to add a helper you can call to trace all <br>
&gt;&gt;&gt;&gt; pages-&gt;dma_address mappings inside a ttm.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; One thing at a time :-).&nbsp; That would probably be a bit be=
tter since <br>
&gt;&gt;&gt; the trace log gets filled with remappings (which is why my <br=
>
&gt;&gt;&gt; proof-of-concept umr patch only grabs the latest mapping as it=
 reads <br>
&gt;&gt;&gt; the trace).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Is there a handy place we can grab a list of ttm_tt's bound to=
 our <br>
&gt;&gt;&gt; device?&nbsp; If so then in theory I could write a debugfs int=
erface <br>
&gt;&gt;&gt; instead.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks for your patience as I'm definitely less familiar with =
the VM <br>
&gt;&gt;&gt; side of things :-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Cheers,<br>
&gt;&gt;&gt; Tom<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx" id=3D"LPlnk518445" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15016027613140.08295823990357198" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15016027613110.1813202064689361" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15016027613120.5421751103538535" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15016027613120.2548737792421861"></div>
<div id=3D"LPTitle_15016027613120.23212871138685842" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&qu=
ot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line=
-height: 21px;">
<a id=3D"LPUrlAnchor_15016027613130.2533724279446574" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15016027613130.7874404914990427" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15016027613130.5169047949058398" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Aria=
l,sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overfl=
ow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 id=3D"LPlnk434060" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15016027613220.7871711856219648" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15016027613190.2615781169078024" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15016027613200.08716742963535162" style=3D"vertical-alig=
n: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15016027613200.6016969126942272"></div>
<div id=3D"LPTitle_15016027613200.1704710881698085" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quo=
t;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-=
height: 21px;">
<a id=3D"LPUrlAnchor_15016027613210.1055556852355326" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15016027613210.07358644878449205" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma=
,Arial,sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15016027613210.74097043846146" style=3D"display: b=
lock; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_se=
goe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,=
sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow=
: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk374752" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15016028208780.5931683559589285" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15016028208740.92491337649414" style=3D"width: 90%=
; background-color: rgb(255, 255, 255); position: relative; overflow: auto;=
 padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1px=
 dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);" =
role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15016028208750.5039491761540736" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15016028208750.8435103435108974"></div>
<div id=3D"LPTitle_15016028208750.3076890768275301" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quo=
t;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-=
height: 21px;">
<a id=3D"LPUrlAnchor_15016028208760.5932119976653863" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15016028208760.3609779223258601" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15016028208770.6822461316553391" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Aria=
l,sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overfl=
ow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB12572F535B64B97DF2C93C6EF2B30DM5PR12MB1257namp_--

--===============0297844164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0297844164==--

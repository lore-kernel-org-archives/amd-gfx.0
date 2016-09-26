From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix addr handling in
 amdgpu_vm_bo_update_mapping
Date: Mon, 26 Sep 2016 13:46:13 +0000
Message-ID: <CY4PR12MB1768C24C35861367BAD1BA07F7CD0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1474797313-1994-1-git-send-email-deathsimple@vodafone.de>
 <20160926071900.GF9691@flora> <20160926091624.GG9691@flora>,
 <5336fe95-9645-0c9c-e948-1e51811ad907@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0396253478=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5336fe95-9645-0c9c-e948-1e51811ad907-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0396253478==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768C24C35861367BAD1BA07F7CD0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768C24C35861367BAD1BA07F7CD0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm reading through the amdgpu_vm.c to try and see if the patch is correct =
but I'm not that familiar with the VM side of things.  It seems to boil dow=
n to calling params->func() with a new dst value of NULL but that's where I=
'm stopped at the moment since I don't know what func() is.  Nothing up to =
that point looks overtly wrong (like trying to use that address as a source=
 for a read/write).


Tom

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Monday, September 26, 2016 09:29
To: Cui, Flora
Cc: Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_update_m=
apping

Yeah, that wouldn't really help but just make the problem more unlikely
to happen once more.

Anyway Tom St confirmed that the patch seems to work for the open stack.

Anybody brave enough to throw an rb on this so that I can commit it?

Thanks,
Christian.

Am 26.09.2016 um 11:16 schrieb Flora Cui:
> please ignore this patch. it actually revert the gtt mgr changes.
>
> On Mon, Sep 26, 2016 at 03:19:01PM +0800, Flora Cui wrote:
>> On Sun, Sep 25, 2016 at 11:55:13AM +0200, Christian K=F6nig wrote:
>>> From: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>>
>>> Otherwise we will look at the wrong place in the IB when GART
>>> mappings are split into smaller updates.
>>>
>>> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
>>> index 2bb78dc..da31189 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1017,6 +1017,7 @@ static int amdgpu_vm_bo_update_mapping(struct amd=
gpu_device *adev,
>>>                                                  AMDGPU_GPU_PAGE_SIZE);
>>>                      pte[i] |=3D flags;
>>>              }
>>> +           addr =3D 0;
>>>      }
>>>
>>>      r =3D amdgpu_sync_fence(adev, &job->sync, exclusive);
>>> --
>>> 2.5.0
>>>
>>>
>> IMHO this could fix the vmfault issue.
>>
>> 8<---
>>  From cc7b5618665defd88e2adcd6f735562ecd784298 Mon Sep 17 00:00:00 2001
>> From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
>> Date: Mon, 26 Sep 2016 15:14:02 +0800
>> Subject: [PATCH] drm/amdgpu: add ttm_bind in amdgpu_vm_bo_update()
>>
>> Change-Id: If73d5b06e9188e40250ccdfd1a2a659ed1ef52a6
>> Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm.c
>> index 2bb78dc..7f17127 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1166,6 +1166,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
,
>>                       ttm =3D container_of(bo_va->bo->tbo.ttm, struct
>>                                          ttm_dma_tt, ttm);
>>                       pages_addr =3D ttm->dma_address;
>> +                    amdgpu_ttm_bind(&bo_va->bo->tbo, mem);
>> +                    addr =3D (u64)mem->start << PAGE_SHIFT;
>>                       break;
>>
>>               case TTM_PL_VRAM:
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1768C24C35861367BAD1BA07F7CD0CY4PR12MB1768namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>I'm reading through the amdgpu_vm.c to try and see if the patch is corre=
ct but I'm not that familiar with the VM side of things. &nbsp;It seems to =
boil down to calling params-&gt;func() with a new dst value of NULL but tha=
t's where I'm stopped at the moment since
 I don't know what func() is. &nbsp;Nothing up to that point looks overtly =
wrong (like trying to use that address as a source for a read/write).</p>
<p><br>
</p>
<p>Tom</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;death=
simple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, September 26, 2016 09:29<br>
<b>To:</b> Cui, Flora<br>
<b>Cc:</b> Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix addr handling in amdgpu_vm_bo_u=
pdate_mapping</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Yeah, that wouldn't really help but just make the =
problem more unlikely
<br>
to happen once more.<br>
<br>
Anyway Tom St confirmed that the patch seems to work for the open stack.<br=
>
<br>
Anybody brave enough to throw an rb on this so that I can commit it?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.09.2016 um 11:16 schrieb Flora Cui:<br>
&gt; please ignore this patch. it actually revert the gtt mgr changes.<br>
&gt;<br>
&gt; On Mon, Sep 26, 2016 at 03:19:01PM &#43;0800, Flora Cui wrote:<br>
&gt;&gt; On Sun, Sep 25, 2016 at 11:55:13AM &#43;0200, Christian K=F6nig wr=
ote:<br>
&gt;&gt;&gt; From: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Otherwise we will look at the wrong place in the IB when GART<=
br>
&gt;&gt;&gt; mappings are split into smaller updates.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 &#43;<b=
r>
&gt;&gt;&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; index 2bb78dc..da31189 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt;&gt; @@ -1017,6 &#43;1017,7 @@ static int amdgpu_vm_bo_update_mappi=
ng(struct amdgpu_device *adev,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; AMDGPU_GPU_PAGE_SIZE);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte[i] |=3D=
 flags;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; addr =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_sync_fence(adev, &a=
mp;job-&gt;sync, exclusive);<br>
&gt;&gt;&gt; -- <br>
&gt;&gt;&gt; 2.5.0<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt; IMHO this could fix the vmfault issue.<br>
&gt;&gt;<br>
&gt;&gt; 8&lt;---<br>
&gt;&gt;&nbsp; From cc7b5618665defd88e2adcd6f735562ecd784298 Mon Sep 17 00:=
00:00 2001<br>
&gt;&gt; From: Flora Cui &lt;Flora.Cui-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; Date: Mon, 26 Sep 2016 15:14:02 &#43;0800<br>
&gt;&gt; Subject: [PATCH] drm/amdgpu: add ttm_bind in amdgpu_vm_bo_update()=
<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: If73d5b06e9188e40250ccdfd1a2a659ed1ef52a6<br>
&gt;&gt; Signed-off-by: Flora Cui &lt;Flora.Cui-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 &#43;&#43;<=
br>
&gt;&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; index 2bb78dc..7f17127 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt;&gt; @@ -1166,6 &#43;1166,8 @@ int amdgpu_vm_bo_update(struct amdgpu_de=
vice *adev,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm =3D c=
ontainer_of(bo_va-&gt;bo-&gt;tbo.ttm, struct<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_dma_tt, ttm);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_add=
r =3D ttm-&gt;dma_address;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_bind(&amp;=
bo_va-&gt;bo-&gt;tbo, mem);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr =3D (u64)mem-&gt=
;start &lt;&lt; PAGE_SHIFT;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br=
>
&gt;&gt;&nbsp;&nbsp; <br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; case TTM_PL_VRAM:<br>
&gt;&gt; -- <br>
&gt;&gt; 2.7.4<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 id=3D"LPlnk752113">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14748974921180.061148974248180776" style=3D"margin-b=
ottom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14748974921150.5420295662969261" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14748974921160.9203516131537464" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_14748974921170.6190799743922379"></div>
<div id=3D"LPTitle_14748974921170.667584414663523" style=3D"top: 0px; color=
: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_s=
egoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quo=
t;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-hei=
ght: 21px;">
<a id=3D"LPUrlAnchor_14748974921170.2600095206173294" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14748974921170.8198680036506909" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14748974921180.08916125964466382" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
 hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768C24C35861367BAD1BA07F7CD0CY4PR12MB1768namp_--

--===============0396253478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0396253478==--

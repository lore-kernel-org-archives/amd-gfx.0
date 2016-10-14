From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce ring
Date: Fri, 14 Oct 2016 15:15:30 +0200
Message-ID: <CAD=4a=VjQmmZtLb9h87jzm_Oha+NOLZ83JeYRreQzwsK7aCZTw@mail.gmail.com>
References: <1476449341-2673-1-git-send-email-ernstp@gmail.com>
 <CY4PR12MB1768CDAC43129C814D75DCE0F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=XdwL5AaZ=kJKQXWgcYPUYrCJd4SMXT9FH470Ei5_dqOA@mail.gmail.com>
 <CY4PR12MB1768287E6AD0257F6330C5CFF7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0597225632=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768287E6AD0257F6330C5CFF7DF0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0597225632==
Content-Type: multipart/alternative; boundary=94eb2c0bc3fc4e3aea053ed30582

--94eb2c0bc3fc4e3aea053ed30582
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'm testing both drm-next-4.9 and drm-next-4.9-wip from ~agd5f.
I think the problem is in drm-next now also.
They all have
6f0359f drm/amdgpu/vce3: add support for third vce ring
75c6548 drm/amdgpu: track the number of vce rings

But not
9d24b30 drm/amdgpu: fix broken VCE startup in phys mode
which only exists in amd-staging-4.7
(What does 4.7 mean in this context... ?)

Regards
//Ernst


2016-10-14 15:07 GMT+02:00 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>:

> Do you have https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3D
> drm-next-4.7-wip&id=3D9d24b304abbe5380da1bc782b4460596e7cb1109 as well?
>
>
> I've booted the tip of our staging-4.7 branch with a FIJI device (FURY)
> and was able to play videos (vdpau) and normal GL apps.
>
>
> Tom
>
>
> ------------------------------
> *From:* Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, October 14, 2016 09:05
> *To:* StDenis, Tom
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] amdgpu: Fix failing boot after support for third
> vce ring
>
> Yes, the  6f0359ff73076483902de0c17f9649bf55651e2a I'm referring to is
> the same as
> 780605db12c52f2c22d4d2cc05ceb7d2a9d55579 (only exists in amd-staging).
> So the last of those two commits is the one that causes my problem.
>
> Regards
> //Ernst
>
> 2016-10-14 14:53 GMT+02:00 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>:
>
>> Does your tree have
>>
>>
>> 2f3d686d0ee95332d8888169c7b6788bb2d9f5ad
>>
>> 780605db12c52f2c22d4d2cc05ceb7d2a9d55579
>>
>>
>> in it?  Those are fixes for when the third ring were added.
>>
>>
>> Tom
>>
>>
>> ------------------------------
>> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
>> Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> *Sent:* Friday, October 14, 2016 08:49
>> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Cc:* Ernst Sj=C3=B6strand
>> *Subject:* [PATCH] amdgpu: Fix failing boot after support for third vce
>> ring
>>
>> My Fiji class Fury fails to boot after commit
>> 6f0359ff73076483902de0c17f9649bf55651e2a
>> "drm/amdgpu/vce3: add support for third vce ring"
>> This commits reverts the number of vce rings back to 2,
>> but leaves the other changes intact.
>>
>> Signed-off-by: Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 3f899e3..6f5eb64 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -358,7 +358,7 @@ static int vce_v3_0_early_init(void *handle)
>>              (AMDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))
>>                  return -ENOENT;
>>
>> -       adev->vce.num_rings =3D 3;
>> +       adev->vce.num_rings =3D 2;
>>
>>          vce_v3_0_set_ring_funcs(adev);
>>          vce_v3_0_set_irq_funcs(adev);
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> amd-gfx Info Page - lists.freedesktop.org
>> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>> lists.freedesktop.org
>> To see the collection of prior postings to the list, visit the amd-gfx
>> Archives. Using amd-gfx: To post a message to all the list members, send
>> email ...
>>
>>
>>
>

--94eb2c0bc3fc4e3aea053ed30582
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>I&#39;m testing both dr=
m-next-4.9 and drm-next-4.9-wip from ~agd5f.<br></div>I think the problem i=
s in drm-next now also.<br></div>They all have<br>6f0359f drm/amdgpu/vce3: =
add support for third vce ring<br>75c6548 drm/amdgpu: track the number of v=
ce rings<br><br></div>But not<br>9d24b30 drm/amdgpu: fix broken VCE startup=
 in phys mode<br></div>which only exists in amd-staging-4.7<br></div>(What =
does 4.7 mean in this context... ?)<br><br></div>Regards<br></div>//Ernst<b=
r><div><div><div><br></div></div></div></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">2016-10-14 15:07 GMT+02:00 StDenis, Tom <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom=
.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"m_-8133334703298494421divtagdefaultwrapper" style=3D"font-size:1=
2pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Do you have=C2=A0<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/co=
mmit/?h=3Ddrm-next-4.7-wip&amp;id=3D9d24b304abbe5380da1bc782b4460596e7cb110=
9" class=3D"m_-8133334703298494421OWAAutoLink" id=3D"m_-8133334703298494421=
LPlnk640528" target=3D"_blank">https://cgit.freedesktop.<wbr>org/~agd5f/lin=
ux/commit/?h=3D<wbr>drm-next-4.7-wip&amp;id=3D<wbr>9d24b304abbe5380da1bc782=
b44605<wbr>96e7cb1109</a>=C2=A0as
 well?</p>
<p><br>
</p>
<p>I&#39;ve booted the tip of our staging-4.7 branch with a FIJI device (FU=
RY) and was able to play videos (vdpau) and normal GL apps.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-8133334703298494421divRplyFwdMsg" dir=3D"ltr"><font style=3D"=
font-size:11pt" color=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b>=
 Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_bl=
ank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:05<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</font>
<div>=C2=A0</div>
</div><div><div class=3D"h5">
<div>
<div dir=3D"ltr">
<div>Yes, the=C2=A0 6f0359ff73076483902de0c17f9649<wbr>bf55651e2a I&#39;m r=
eferring to is the same as
<br>
<span><span>780605db12c52f2c22d4d2cc05ceb7<wbr>d2a9d55579 (only exists in a=
md-staging).<br>
</span></span></div>
<span><span>So the last of those two commits is the one that causes my prob=
lem.<br>
</span></span>
<div><span><span><br>
</span></span></div>
<div><span><span>Regards<br>
</span></span></div>
<div><span><span>//Ernst<br>
</span></span></div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">2016-10-14 14:53 GMT+02:00 StDenis, Tom <span di=
r=3D"ltr">
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_-8133334703298494421m_-1771598304858325824divtagdefaultwrapper=
" style=3D"font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica=
,sans-serif">
<p>Does your tree have=C2=A0</p>
<p><br>
</p>
<p><span>2f3d686d0ee95332d8888169c7b678<wbr>8bb2d9f5ad</span><br>
</p>
<p><span><span>780605db12c52f2c22d4d2cc05ceb7<wbr>d2a9d55579</span><br>
</span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>in it?=C2=A0 Those are fixes for when the third ring were ad=
ded.</span></span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>Tom</span></span></p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-8133334703298494421m_-1771598304858325824x_divRplyFwdMsg" dir=
=3D"ltr"><font style=3D"font-size:11pt" color=3D"#000000" face=3D"Calibri, =
sans-serif"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@list=
s.freedesktop.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org<wbr>ktop=
.org</a>&gt;
 on behalf of Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 08:49<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Ernst Sj=C3=B6strand<br>
<b>Subject:</b> [PATCH] amdgpu: Fix failing boot after support for third vc=
e ring</font>
<div>=C2=A0</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"m_-8133334703298494421m_-1771598304858325824PlainText">
<div>
<div class=3D"m_-8133334703298494421h5">My Fiji class Fury fails to boot af=
ter commit<br>
6f0359ff73076483902de0c17f9649<wbr>bf55651e2a<br>
&quot;drm/amdgpu/vce3: add support for third vce ring&quot;<br>
This commits reverts the number of vce rings back to 2,<br>
but leaves the other changes intact.<br>
<br>
Signed-off-by: Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/vc<wbr>e_v3_0.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/v<wbr>ce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/v<wbr>ce_v3_0.c<br>
index 3f899e3..6f5eb64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/v<wbr>ce_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/v<wbr>ce_v3_0.c<br>
@@ -358,7 +358,7 @@ static int vce_v3_0_early_init(void *handle)<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (A=
MDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -ENOENT;<br>
=C2=A0<br>
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;vce.num_rings =3D 3;<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;vce.num_rings =3D 2;<br>
=C2=A0<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vce_v3_0_set_ring_funcs(ad=
ev);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vce_v3_0_set_irq_funcs(ade=
v);<br>
-- <br>
2.7.4<br>
<br>
</div>
</div>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"m_=
-8133334703298494421m_-1771598304858325824LPlnk959250" target=3D"_blank">ht=
tps://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
<div id=3D"m_-8133334703298494421m_-1771598304858325824LPBorder_GT_14764495=
470470.9881266530783932" style=3D"margin-bottom:20px;overflow:auto;width:10=
0%;text-indent:0px">
<table id=3D"m_-8133334703298494421m_-1771598304858325824LPContainer_147644=
95470450.11026149163994892" style=3D"width:90%;background-color:rgb(255,255=
,255);overflow:auto;padding-top:20px;padding-bottom:20px;margin-top:20px;bo=
rder-top:1px dotted rgb(200,200,200);border-bottom:1px dotted rgb(200,200,2=
00)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"m_-8133334703298494421m_-1771598304858325824TextCell_147644954704=
60.7288026297683508" colspan=3D"2" style=3D"vertical-align:top;padding:0px;=
display:table-cell">
<div id=3D"m_-8133334703298494421m_-1771598304858325824LPRemovePreviewConta=
iner_14764495470460.16427690046159027">
</div>
<div id=3D"m_-8133334703298494421m_-1771598304858325824LPTitle_147644954704=
60.741636132433581" style=3D"color:rgb(59,87,119);font-weight:normal;font-s=
ize:21px;font-family:wf_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Seg=
oe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sa=
ns-serif;line-height:21px">
<a id=3D"m_-8133334703298494421m_-1771598304858325824LPUrlAnchor_1476449547=
0460.2698087919077241" href=3D"https://lists.freedesktop.org/mailman/listin=
fo/amd-gfx" style=3D"text-decoration:none" target=3D"_blank">amd-gfx Info P=
age - lists.freedesktop.org</a></div>
<div id=3D"m_-8133334703298494421m_-1771598304858325824LPMetadata_147644954=
70460.18698958466014992" style=3D"margin:10px 0px 16px;color:rgb(102,102,10=
2);font-weight:normal;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&=
quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-height:14px=
">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"m_-8133334703298494421m_-1771598304858325824LPDescription_147644=
95470460.6448197846508978" style=3D"display:block;color:rgb(102,102,102);fo=
nt-weight:normal;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;=
Segoe WP&quot;,Tahoma,Arial,sans-serif;font-size:14px;line-height:20px;max-=
height:100px;overflow:hidden">
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
</div>
</span></font></div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>

--94eb2c0bc3fc4e3aea053ed30582--

--===============0597225632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0597225632==--

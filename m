From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed
Date: Tue, 23 Oct 2018 09:08:44 +0000
Message-ID: <BYAPR12MB27751FC5C849094C1C695CCFFBF50@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1540265370-23923-1-git-send-email-Rex.Zhu@amd.com>
 <7b50f2a1-791e-8eab-6777-e7fff572565c@amd.com>
 <BYAPR12MB2775C0F7BCA52B2969C9D16EFBF50@BYAPR12MB2775.namprd12.prod.outlook.com>,
 <62aee584-d4b1-dd9b-234e-8ca7d7a23a29@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <62aee584-d4b1-dd9b-234e-8ca7d7a23a29-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--_004_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_"

--_000_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


You can reproduce this issue by allocate CSA buffer in baremetal and map th=
em to reserved VM address.


Please see the attached patch.


Best Regards

Rex



________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, October 23, 2018 5:01 PM
To: Zhu, Rex; Zhang, Jerry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexand=
er; Koenig, Christian
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed

Hi guys,

yeah the root PD doesn't necessarily have a power of two entries.

But what exactly was the problem with the original code? Why does 0xfffffff=
f doesn't work?

The only possible explanation I can see is that somebody tried to use an ad=
dress which is above max_pfn, or how did that trigger?

Thanks,
Christian.

Am 23.10.18 um 07:42 schrieb Zhu, Rex:

No, if the vm size is small, there may only on root pd entry.

we need to make sure the mask >=3D 0;


Maybe this change revert Christian's commit:


commit 72af632549b97ead9251bb155f08fefd1fb6f5c3
Author: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.koeni=
g@amd.com>
Date:   Sat Sep 15 10:02:13 2018 +0200

    drm/amdgpu: add amdgpu_vm_entries_mask v2

    We can't get the mask for the root directory from the number of entries=
.

    So add a new function to avoid that problem.


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Zhang, Jerry(Junwei) <Jerry.Zhang@amd=
.com><mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, October 23, 2018 1:12 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org>; Deucher, Alexander; Koenig, Christian
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed

On 10/23/2018 11:29 AM, Rex Zhu wrote:
> when the VA address located in the last PD entries,
> the alloc_pts will faile.
>
> Use the right PD mask instand of hardcode, suggested
> by jerry.zhang.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org><mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Thanks to verify that.
Feel free to add
Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org><mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>

Also like to get to know some background about these two functions from
Christian.
Perhaps we may make it more simple, e.g. merging them together.

Regards,
Jerry

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 054633b..3939013 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -202,8 +202,11 @@ static unsigned amdgpu_vm_num_entries(struct amdgpu_=
device *adev,
>   static uint32_t amdgpu_vm_entries_mask(struct amdgpu_device *adev,
>                                       unsigned int level)
>   {
> +     unsigned shift =3D amdgpu_vm_level_shift(adev,
> +                                            adev->vm_manager.root_level)=
;
> +
>        if (level <=3D adev->vm_manager.root_level)
> -             return 0xffffffff;
> +             return (round_up(adev->vm_manager.max_pfn, 1 << shift) >> s=
hift) - 1;
>        else if (level !=3D AMDGPU_VM_PTB)
>                return 0x1ff;
>        else

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>. Yo=
u can subscribe to the list, or change your existing subscription, in the s=
ections below.





_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Christian,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">You can reproduce this issue by a=
llocate CSA buffer in baremetal and map them to reserved VM address.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Please see the attached patch.</p=
>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &l=
t;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 23, 2018 5:01 PM<br>
<b>To:</b> Zhu, Rex; Zhang, Jerry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, =
Alexander; Koenig, Christian<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed</fon=
t>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">Hi guys,<br>
<br>
yeah the root PD doesn't necessarily have a power of two entries.<br>
<br>
But what exactly was the problem with the original code? Why does 0xfffffff=
f doesn't work?<br>
<br>
The only possible explanation I can see is that somebody tried to use an ad=
dress which is above max_pfn, or how did that trigger?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 23.10.18 um 07:42 schrieb Zhu, Rex:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">No, if the vm size is small, the=
re may only on root pd entry.</p>
<p style=3D"margin-top:0; margin-bottom:0">we need to make sure the mask &g=
t;=3D 0;</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Maybe this change revert Christi=
an's commit:</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<div>commit 72af632549b97ead9251bb155f08fefd1fb6f5c3<br>
Author: Christian K=F6nig <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" =
href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk32464" previewremoved=
=3D"true">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
Date:&nbsp;&nbsp; Sat Sep 15 10:02:13 2018 &#43;0200<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amdgpu: add amdgpu_vm_entries_mask v2<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; We can't get the mask for the root directory from the nu=
mber of entries.<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; So add a new function to avoid that problem.</div>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%" tabindex=3D"-1">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" href=3D"mailto:amd-gfx-bou=
nces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk298439" previewremoved=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Zhang, Jerry=
(Junwei) <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" href=3D"mailto:Je=
rry.Zhang-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk595359" previewremoved=3D"true">
&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Tuesday, October 23, 2018 1:12 PM<br>
<b>To:</b> Zhu, Rex; <a class=3D"x_moz-txt-link-abbreviated OWAAutoLink" hr=
ef=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk144243" previewremov=
ed=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander; Koenig, Christian<br=
>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">On 10/23/2018 11:29 AM, Rex Zhu wrote:<br>
&gt; when the VA address located in the last PD entries,<br>
&gt; the alloc_pts will faile.<br>
&gt;<br>
&gt; Use the right PD mask instand of hardcode, suggested<br>
&gt; by jerry.zhang.<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink=
" href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk300100" previewremoved=3D"true=
">
&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Thanks to verify that.<br>
Feel free to add<br>
Reviewed-by: Junwei Zhang <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLink" =
href=3D"mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk163240" previewremoved=3D"tr=
ue">
&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Also like to get to know some background about these two functions from <br=
>
Christian.<br>
Perhaps we may make it more simple, e.g. merging them together.<br>
<br>
Regards,<br>
Jerry<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 &#43;&#43;&#43;=
&#43;-<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 054633b..3939013 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -202,8 &#43;202,11 @@ static unsigned amdgpu_vm_num_entries(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp; static uint32_t amdgpu_vm_entries_mask(struct amdgpu_devic=
e *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; unsigned int level)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned shift =3D amdgpu_vm_level_shift=
(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vm_manager.root_level)=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (level &lt;=3D adev-&gt;v=
m_manager.root_level)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0xffffffff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return (round_up(adev-&gt;vm_manager.max_pfn, 1 &lt;&lt; shift) &gt=
;&gt; shift) - 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (level !=3D AMDGPU_V=
M_PTB)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0x1ff;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"x_moz-txt-link-abbreviated OWAAutoLink" href=3D"mailto:amd-gfx@=
lists.freedesktop.org" id=3D"LPlnk365121" previewremoved=3D"true">amd-gfx@l=
ists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk206689" class=3D"x_OWAAutoLink" previewremoved=3D"true">https://lists.fr=
eedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15402730099220.06989990489403342" style=3D"margin-bo=
ttom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"f=
alse">
<table id=3D"LPContainer_15402730099180.16758172594804666" style=3D"width:9=
0%; background-color:rgb(255,255,255); overflow:auto; padding-top:20px; pad=
ding-bottom:20px; margin-top:20px; border-top:1px dotted rgb(200,200,200); =
border-bottom:1px dotted rgb(200,200,200)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"x_TextCell_15402730099180.9196994567727107" colspan=3D"2" style=
=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_15402730099180.46519874882455503" style=3D""><a id=3D"LP=
UrlAnchor_15402730099200.5625533175983499" href=3D"https://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration:=
none">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15402730099200.935286511114562" style=3D"">lists.free=
desktop.org</div>
<div id=3D"LPDescription_15402730099200.10363074579177611" style=3D"">To se=
e the collection of prior postings to the list, visit the amd-gfx Archives.=
. Using amd-gfx: To post a message to all the list members, send email to
<a class=3D"x_moz-txt-link-abbreviated OWAAutoLink" href=3D"mailto:amd-gfx@=
lists.freedesktop.org" id=3D"LPlnk610386" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>. You can subscribe to the list, or change=
 your existing subscription, in the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">____________________________________________=
___=0A=
amd-gfx mailing list=0A=
<a class=3D"x_moz-txt-link-abbreviated OWAAutoLink" href=3D"mailto:amd-gfx@=
lists.freedesktop.org" id=3D"LPlnk840136" previewremoved=3D"true">amd-gfx@l=
ists.freedesktop.org</a>=0A=
<a class=3D"x_moz-txt-link-freetext OWAAutoLink" href=3D"https://lists.free=
desktop.org/mailman/listinfo/amd-gfx" id=3D"LPlnk97345" previewremoved=3D"t=
rue">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=0A=
</pre>
</blockquote>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_--

--_004_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_
Content-Type: text/x-patch; name="0001-debug-create-and-map-csa-buffer.patch"
Content-Description: 0001-debug-create-and-map-csa-buffer.patch
Content-Disposition: attachment;
	filename="0001-debug-create-and-map-csa-buffer.patch"; size=2340;
	creation-date="Tue, 23 Oct 2018 09:08:28 GMT";
	modification-date="Tue, 23 Oct 2018 09:08:28 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhNjhjMDI5ZTJiYzVmNjBmZDI2ZDFiMDcwNWZlZTJiZTgwYjZmNjA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IFR1ZSwg
MjMgT2N0IDIwMTggMTc6MDc6MTIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBkZWJ1ZzogY3JlYXRl
IGFuZCBtYXAgY3NhIGJ1ZmZlcgoKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgfCA0ICsrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9r
bXMuYyAgICB8IDggKysrKy0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwppbmRleCA0NTBiMGI3Li5lMGQ0NmI5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jCkBAIC0xNjU4LDcgKzE2NTgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9k
ZXZpY2VfaXBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCWFkZXYtPmlwX2Js
b2Nrc1tpXS5zdGF0dXMuaHcgPSB0cnVlOwogCiAJCQkvKiByaWdodCBhZnRlciBHTUMgaHcgaW5p
dCwgd2UgY3JlYXRlIENTQSAqLwotCQkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworLy8J
CQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CiAJCQkJciA9IGFtZGdwdV9hbGxvY2F0ZV9z
dGF0aWNfY3NhKGFkZXYsICZhZGV2LT52aXJ0LmNzYV9vYmosCiAJCQkJCQkJCUFNREdQVV9HRU1f
RE9NQUlOX1ZSQU0sCiAJCQkJCQkJCUFNREdQVV9DU0FfU0laRSk7CkBAIC0xNjY2LDcgKzE2NjYs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAkJCQkJRFJNX0VSUk9SKCJhbGxvY2F0ZSBDU0EgZmFpbGVkICVkXG4iLCByKTsK
IAkJCQkJcmV0dXJuIHI7CiAJCQkJfQotCQkJfQorLy8JCQl9CiAJCX0KIAl9CiAKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwppbmRleCBmMmVmOWExLi5iMzMyMjYyIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCkBAIC05NzcsMTMgKzk3NywxMyBA
QCBpbnQgYW1kZ3B1X2RyaXZlcl9vcGVuX2ttcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1
Y3QgZHJtX2ZpbGUgKmZpbGVfcHJpdikKIAkJZ290byBlcnJvcl92bTsKIAl9CiAKLQlpZiAoYW1k
Z3B1X3NyaW92X3ZmKGFkZXYpKSB7CisvLwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CiAJ
CXVpbnQ2NF90IGNzYV9hZGRyID0gYW1kZ3B1X2NzYV92YWRkcihhZGV2LCAxKSAmIEFNREdQVV9H
TUNfSE9MRV9NQVNLOwogCQlyID0gYW1kZ3B1X21hcF9zdGF0aWNfY3NhKGFkZXYsICZmcHJpdi0+
dm0sIGFkZXYtPnZpcnQuY3NhX29iaiwKIAkJCQkJCSZmcHJpdi0+Y3NhX3ZhLCBjc2FfYWRkciwg
QU1ER1BVX0NTQV9TSVpFKTsKIAkJaWYgKHIpCiAJCQlnb3RvIGVycm9yX3ZtOwotCX0KKy8vCX0K
IAogCW11dGV4X2luaXQoJmZwcml2LT5ib19saXN0X2xvY2spOwogCWlkcl9pbml0KCZmcHJpdi0+
Ym9fbGlzdF9oYW5kbGVzKTsKQEAgLTEwNDMsMTMgKzEwNDMsMTMgQEAgdm9pZCBhbWRncHVfZHJp
dmVyX3Bvc3RjbG9zZV9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIAogCWFtZGdwdV92bV9i
b19ybXYoYWRldiwgZnByaXYtPnBydF92YSk7CiAKLQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYp
KSB7CisvLwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CiAJCS8qIFRPRE86IGhvdyB0byBo
YW5kbGUgcmVzZXJ2ZSBmYWlsdXJlICovCiAJCUJVR19PTihhbWRncHVfYm9fcmVzZXJ2ZShhZGV2
LT52aXJ0LmNzYV9vYmosIHRydWUpKTsKIAkJYW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBmcHJpdi0+
Y3NhX3ZhKTsKIAkJZnByaXYtPmNzYV92YSA9IE5VTEw7CiAJCWFtZGdwdV9ib191bnJlc2VydmUo
YWRldi0+dmlydC5jc2Ffb2JqKTsKLQl9CisvLwl9CiAKIAlwYXNpZCA9IGZwcml2LT52bS5wYXNp
ZDsKIAlwZCA9IGFtZGdwdV9ib19yZWYoZnByaXYtPnZtLnJvb3QuYmFzZS5ibyk7Ci0tIAoxLjku
MQoK

--_004_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_BYAPR12MB27751FC5C849094C1C695CCFFBF50BYAPR12MB2775namp_--

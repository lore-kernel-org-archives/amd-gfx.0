From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM leaf walking
Date: Mon, 29 Oct 2018 05:45:01 +0000
Message-ID: <BYAPR12MB2775E7DEF317D43C6C691EF1FBF30@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20181025143804.1698-1-christian.koenig@amd.com>
 <BN6PR12MB180949222B5967C8A2DD147DF7F70@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BYAPR12MB2775292DA22A6D78872926DDFBF70@BYAPR12MB2775.namprd12.prod.outlook.com>
 <BYAPR12MB2775D822132203F5E206128EFBF70@BYAPR12MB2775.namprd12.prod.outlook.com>,
 <c3a525d1-2537-f561-5bd1-5b862a0d3e3c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2116259851=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c3a525d1-2537-f561-5bd1-5b862a0d3e3c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============2116259851==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775E7DEF317D43C6C691EF1FBF30BYAPR12MB2775namp_"

--_000_BYAPR12MB2775E7DEF317D43C6C691EF1FBF30BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

That sounds reasonable.

Thanks.


Best Regards

Rex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, October 26, 2018 3:34 PM
To: Zhu, Rex; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: fix VM leaf walking

Yeah, that came to my mind as well.

But this is the only case where we would use the return value and not use c=
ursor->pfn as criteria to abort.

So to be consistent I rather don't want to do this,
Christian.

Am 25.10.18 um 17:43 schrieb Zhu, Rex:

How about add a return value for the function amdgpu_vm_pt_next?

And change the code as:



     ret =3D amdgpu_vm_pt_next(adev, cursor);
-       while (amdgpu_vm_pt_descendant(adev, cursor));
+       if (!ret)
+               while (amdgpu_vm_pt_descendant(adev, cursor));



Best Regards

Rex

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> On Behalf Of Zhu, Rex
Sent: Thursday, October 25, 2018 11:34 PM
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org><mailto:Alexander.Deucher=
@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:ckoe=
nig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx=
@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix VM leaf walking



Patch is Tested-by:  Rex Zhu Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>



Regards

Rex



From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Deucher, Alexander
Sent: Thursday, October 25, 2018 11:08 PM
To: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.leic=
htzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lists.=
freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix VM leaf walking



Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deucher@=
amd.com>>



________________________________

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Christian K=F6nig <ckoenig.leichtzume=
rken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Thursday, October 25, 2018 10:38 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix VM leaf walking



Make sure we don't try to go down further after the leave walk already
ended. This fixes a crash with a new VM test.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org<mailto:christian=
.koenig-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index db0cbf8d219d..352b30409060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -542,7 +542,8 @@ static void amdgpu_vm_pt_next_leaf(struct amdgpu_device=
 *adev,
                                    struct amdgpu_vm_pt_cursor *cursor)
 {
         amdgpu_vm_pt_next(adev, cursor);
-       while (amdgpu_vm_pt_descendant(adev, cursor));
+       if (cursor->pfn !=3D ~0ll)
+               while (amdgpu_vm_pt_descendant(adev, cursor));
 }

 /**
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_BYAPR12MB2775E7DEF317D43C6C691EF1FBF30BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">That sounds reasonable.</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &l=
t;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, October 26, 2018 3:34 PM<br>
<b>To:</b> Zhu, Rex; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix VM leaf walking</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3DWindows-1252">
<div style=3D"background-color:#FFFFFF">
<div class=3D"x_moz-cite-prefix">Yeah, that came to my mind as well.<br>
<br>
But this is the only case where we would use the return value and not use c=
ursor-&gt;pfn as criteria to abort.<br>
<br>
So to be consistent I rather don't want to do this,<br>
Christian.<br>
<br>
Am 25.10.18 um 17:43 schrieb Zhu, Rex:<br>
</div>
<blockquote type=3D"cite">
<meta name=3D"x_Generator" content=3D"Microsoft Word 15 (filtered=0A=
        medium)">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"color:black">How about add a return=
 value for the function amdgpu_vm_pt_next?</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">And change the code as=
:</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;&nbsp;&nbsp;&nbs=
p;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"color:black">&nbsp;&nbsp;&nbsp;&nbs=
p; ret =3D amdgpu_vm_pt_next(adev, cursor);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (amdgpu_vm_pt_descendant(adev, =
cursor));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (amdgpu_vm_pt_descendant(adev, cursor));</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Best Regards</p>
<p class=3D"x_MsoNormal">Rex</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in=0A=
          0in 0in 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1=0A=
              1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx <a class=3D"x_moz-txt-link-rf=
c2396E OWAAutoLink" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" i=
d=3D"LPlnk888612" previewremoved=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> <b>On Behalf Of </b>Zhu, =
Rex<br>
<b>Sent:</b> Thursday, October 25, 2018 11:34 PM<br>
<b>To:</b> Deucher, Alexander <a class=3D"x_moz-txt-link-rfc2396E OWAAutoLi=
nk" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk565645" previewrem=
oved=3D"true">
&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>; Christian K=F6nig <a class=3D"x_moz-=
txt-link-rfc2396E OWAAutoLink" href=3D"mailto:ckoenig.leichtzumerken@gmail.=
com" id=3D"LPlnk287786" previewremoved=3D"true">
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; <a class=3D"x_moz-txt-link-ab=
breviated OWAAutoLink" href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"=
LPlnk79687" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix VM leaf walking</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Patch is Tested-by: &nbsp;Rex Zhu <a href=3D"mailt=
o:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk704517" class=3D"OWAAutoLink" previewremoved=
=3D"true">
Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards</p>
<p class=3D"x_MsoNormal">Rex</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue=0A=
            1.5pt; padding:0in 0in 0in 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1=0A=
                1.0pt; padding:3.0pt 0in 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk256358" class=3D"OWAAutoLink" pr=
eviewremoved=3D"true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Thursday, October 25, 2018 11:08 PM<br>
<b>To:</b> Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com" id=3D"LPlnk748474" class=3D"OWAAutoLink" previewremoved=3D"true">=
ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk324756" class=
=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix VM leaf walking</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt; color:black">Acked-by: Alex Deucher &lt=
;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk291278" class=3D"O=
WAAutoLink" previewremoved=3D"true">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;</span=
></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
<div>
<div class=3D"x_MsoNormal" style=3D"text-align:center" align=3D"center"><sp=
an style=3D"font-size:12.0pt; color:black">
<hr width=3D"98%" size=3D"3" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lis=
ts.freedesktop.org" id=3D"LPlnk120770" class=3D"OWAAutoLink" previewremoved=
=3D"true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerke=
n@gmail.com" id=3D"LPlnk612085" class=3D"OWAAutoLink" previewremoved=3D"tru=
e">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, October 25, 2018 10:38 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk9519=
54" class=3D"OWAAutoLink" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix VM leaf walking</span><span style=
=3D"font-size:12.0pt; color:black">
</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">&nbs=
p;</span></p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"color:black">Make sure we don't try=
 to go down further after the leave walk already<br>
ended. This fixes a crash with a new VM test.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@amd=
.com" id=3D"LPlnk86451" class=3D"OWAAutoLink" previewremoved=3D"true">chris=
tian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index db0cbf8d219d..352b30409060 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -542,7 &#43;542,8 @@ static void amdgpu_vm_pt_next_leaf(struct amdgpu_de=
vice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
vm_pt_cursor *cursor)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_next(adev, cu=
rsor);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (amdgpu_vm_pt_descendant(adev, =
cursor));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cursor-&gt;pfn !=3D ~0ll)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (amdgpu_vm_pt_descendant(adev, cursor));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"LPlnk546581" class=
=3D"OWAAutoLink" previewremoved=3D"true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><=
br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk692300" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2775E7DEF317D43C6C691EF1FBF30BYAPR12MB2775namp_--

--===============2116259851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2116259851==--

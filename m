From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] amdgpu: Fix failing boot after support for third vce ring
Date: Fri, 14 Oct 2016 13:49:00 +0000
Message-ID: <MWHPR12MB169476FBE38ABF8A3A991604F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <1476449341-2673-1-git-send-email-ernstp@gmail.com>
 <CY4PR12MB1768CDAC43129C814D75DCE0F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=XdwL5AaZ=kJKQXWgcYPUYrCJd4SMXT9FH470Ei5_dqOA@mail.gmail.com>
 <CY4PR12MB1768287E6AD0257F6330C5CFF7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=VjQmmZtLb9h87jzm_Oha+NOLZ83JeYRreQzwsK7aCZTw@mail.gmail.com>
 <CAD=4a=VHdJ1WKE3XQmiSK+-M2NLfZq5N6kgU_J7tcjVmmz8vpg@mail.gmail.com>,
 <CAD=4a=XVD6dq7KWFtY9r5qS4saARoXvpqLcshX1L=Vibri7cLA@mail.gmail.com>
 <CY4PR12MB1768FB1C0830FC368B671BC5F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1507784182=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768FB1C0830FC368B671BC5F7DF0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Ernst_Sj=F6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1507784182==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB169476FBE38ABF8A3A991604F7DF0MWHPR12MB1694namp_"

--_000_MWHPR12MB169476FBE38ABF8A3A991604F7DF0MWHPR12MB1694namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

All of those patches are integrated:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&id=
=3D57da26e4c4c1c7cc042aba1925813fea7413dbeb
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&id=
=3Dd7ca7ab8259f43473bc387dda2a5b84aeb049961


From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Friday, October 14, 2016 9:21 AM
To: Ernst Sj=F6strand
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce r=
ing


You'd need



https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&id=
=3D9ab4662c313d25731e53cc4f044bddb9c506ca13

and

https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&id=
=3Dda00756f75422b04befae381e7e48d0cacf299f3



I'll let Alex speak for the drm-next branches since he manages them.



Tom

________________________________
From: Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, October 14, 2016 09:20
To: StDenis, Tom
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce r=
ing

Means the drm pull request for 4.9 is broken then also, FYI.

2016-10-14 15:17 GMT+02:00 Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ernst=
p@gmail.com>>:
9d24b304abbe5380da1bc782b4460596e7cb1109
cherry-picks cleanly on drm-next-4.9-wip but then fails to build:

  CC [M]  drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:2: error: unknown field 'type' sp=
ecified in initializer
  .type =3D AMDGPU_RING_TYPE_VCE,
  ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: warning: initialization makes=
 pointer from integer without a cast [-Wint-conversion]
  .type =3D AMDGPU_RING_TYPE_VCE,
          ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: note: (near initialization fo=
r 'vce_v3_0_ring_phys_funcs.get_rptr')
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:2: error: unknown field 'align_ma=
sk' specified in initializer
  .align_mask =3D 0xf,
  ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: warning: initialization makes=
 pointer from integer without a cast [-Wint-conversion]
  .align_mask =3D 0xf,
                ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: note: (near initialization fo=
r 'vce_v3_0_ring_phys_funcs.get_wptr')
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:856:2: error: unknown field 'nop' spe=
cified in initializer
  .nop =3D VCE_CMD_NO_OP,
  ^

2016-10-14 15:15 GMT+02:00 Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ernst=
p@gmail.com>>:
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


2016-10-14 15:07 GMT+02:00 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:Tom.StD=
enis-5C7GfCeVMHo@public.gmane.org>>:

Do you have https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-=
4.7-wip&id=3D9d24b304abbe5380da1bc782b4460596e7cb1109 as well?



I've booted the tip of our staging-4.7 branch with a FIJI device (FURY) and=
 was able to play videos (vdpau) and normal GL apps.



Tom

________________________________
From: Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, October 14, 2016 09:05
To: StDenis, Tom
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce r=
ing

Yes, the  6f0359ff73076483902de0c17f9649bf55651e2a I'm referring to is the =
same as
780605db12c52f2c22d4d2cc05ceb7d2a9d55579 (only exists in amd-staging).
So the last of those two commits is the one that causes my problem.

Regards
//Ernst

2016-10-14 14:53 GMT+02:00 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:Tom.StD=
enis-5C7GfCeVMHo@public.gmane.org>>:

Does your tree have



2f3d686d0ee95332d8888169c7b6788bb2d9f5ad

780605db12c52f2c22d4d2cc05ceb7d2a9d55579



in it?  Those are fixes for when the third ring were added.



Tom

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<m=
ailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, October 14, 2016 08:49
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Ernst Sj=F6strand
Subject: [PATCH] amdgpu: Fix failing boot after support for third vce ring

My Fiji class Fury fails to boot after commit
6f0359ff73076483902de0c17f9649bf55651e2a
"drm/amdgpu/vce3: add support for third vce ring"
This commits reverts the number of vce rings back to 2,
but leaves the other changes intact.

Signed-off-by: Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 3f899e3..6f5eb64 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -358,7 +358,7 @@ static int vce_v3_0_early_init(void *handle)
             (AMDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))
                 return -ENOENT;

-       adev->vce.num_rings =3D 3;
+       adev->vce.num_rings =3D 2;

         vce_v3_0_set_ring_funcs(adev);
         vce_v3_0_set_irq_funcs(adev);
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org<http://lists.freedesktop.org>
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...







--_000_MWHPR12MB169476FBE38ABF8A3A991604F7DF0MWHPR12MB1694namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
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
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.m-2167022505463390063hoenzb
	{mso-style-name:m_-2167022505463390063hoenzb;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
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
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">All of those patches are =
integrated:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><a href=3D"https://cgit.f=
reedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&amp;id=3D57da26e4c=
4c1c7cc042aba1925813fea7413dbeb">https://cgit.freedesktop.org/~agd5f/linux/=
commit/?h=3Ddrm-next-4.9-wip&amp;id=3D57da26e4c4c1c7cc042aba1925813fea7413d=
beb</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><a href=3D"https://cgit.f=
reedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&amp;id=3Dd7ca7ab82=
59f43473bc387dda2a5b84aeb049961">https://cgit.freedesktop.org/~agd5f/linux/=
commit/?h=3Ddrm-next-4.9-wip&amp;id=3Dd7ca7ab8259f43473bc387dda2a5b84aeb049=
961</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Friday, October 14, 2016 9:21 AM<br>
<b>To:</b> Ernst Sj=F6strand<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPMetadata_14764495470460.18698958466014992">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">You'd need&nbsp;<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=
=3Ddrm-next-4.7-wip&amp;id=3D9ab4662c313d25731e53cc4f044bddb9c506ca13" id=
=3D"LPlnk511980">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-=
next-4.7-wip&amp;id=3D9ab4662c313d25731e53cc4f044bddb9c506ca13</a><o:p></o:=
p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">and<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=
=3Ddrm-next-4.7-wip&amp;id=3Dda00756f75422b04befae381e7e48d0cacf299f3" id=
=3D"LPlnk276724">https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-=
next-4.7-wip&amp;id=3Dda00756f75422b04befae381e7e48d0cacf299f3</a><o:p></o:=
p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I'll let Alex speak for the drm-next branches since he manages t=
hem.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</=
o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
>ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:20<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Means the drm pull request for 4.9 is broken=
 then also, FYI.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 15:17 GMT&#43;02:00 Ernst Sj=F6st=
rand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ernstp@gmail=
.com</a>&gt;:<o:p></o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">9d24b304abbe5380da1bc782b4460596e7cb1109<o:p=
></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">cherry-picks =
cleanly on drm-next-4.9-wip but then fails to build:<br>
<br>
&nbsp; CC [M]&nbsp; drivers/gpu/drm/amd/amdgpu/vce_v3_0.o<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:2: error: unknown field &#8216;ty=
pe&#8217; specified in initializer<br>
&nbsp; .type =3D AMDGPU_RING_TYPE_VCE,<br>
&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: warning: initialization makes=
 pointer from integer without a cast [-Wint-conversion]<br>
&nbsp; .type =3D AMDGPU_RING_TYPE_VCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: note: (near initialization fo=
r &#8216;vce_v3_0_ring_phys_funcs.get_rptr&#8217;)<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:2: error: unknown field &#8216;al=
ign_mask&#8217; specified in initializer<br>
&nbsp; .align_mask =3D 0xf,<br>
&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: warning: initialization makes=
 pointer from integer without a cast [-Wint-conversion]<br>
&nbsp; .align_mask =3D 0xf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: note: (near initialization fo=
r &#8216;vce_v3_0_ring_phys_funcs.get_wptr&#8217;)<br>
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:856:2: error: unknown field &#8216;no=
p&#8217; specified in initializer<br>
&nbsp; .nop =3D VCE_CMD_NO_OP,<br>
&nbsp; ^<o:p></o:p></span></p>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 15:15 GMT&#43;02:00 Ernst Sj=F6st=
rand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ernstp@gmail=
.com</a>&gt;:<o:p></o:p></span></p>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">I'm testing both drm-next-4.9 and drm-next-4=
.9-wip from ~agd5f.<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">I think the problem is in drm-next now also.=
<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">They all have=
<br>
6f0359f drm/amdgpu/vce3: add support for third vce ring<br>
75c6548 drm/amdgpu: track the number of vce rings<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">But not<br>
9d24b30 drm/amdgpu: fix broken VCE startup in phys mode<o:p></o:p></span></=
p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">which only exists in amd-staging-4.7<o:p></o=
:p></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">(What does 4.=
7 mean in this context... ?)<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Regards<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span class=3D"m-2167022505463390063hoenzb"><span st=
yle=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#888888=
">//Ernst</span><span style=3D"color:#888888"><o:p></o:p></span></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 15:07 GMT&#43;02:00 StDenis, Tom =
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;:<o:p></o:p></span></p>
<div>
<div>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Do you have&nbsp;<a href=3D"https://cgit.freedesktop.org/~agd5f/=
linux/commit/?h=3Ddrm-next-4.7-wip&amp;id=3D9d24b304abbe5380da1bc782b446059=
6e7cb1109" target=3D"_blank" id=3D"m_-2167022505463390063m_7545045248063895=
902m_-8133334703298494421LPlnk640528">https://cgit.freedesktop.org/~agd5f/l=
inux/commit/?h=3Ddrm-next-4.7-wip&amp;id=3D9d24b304abbe5380da1bc782b4460596=
e7cb1109</a>&nbsp;as
 well?<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I've booted the tip of our staging-4.7 branch with a FIJI device=
 (FURY) and was able to play videos (vdpau) and normal GL apps.<o:p></o:p><=
/span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</=
o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:05<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Yes, the&nbsp; 6f0359ff73076483902de0c17f964=
9bf55651e2a I'm referring to is the same as
<br>
780605db12c52f2c22d4d2cc05ceb7d2a9d55579 (only exists in amd-staging).<o:p>=
</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">So the last of those two commits is the one =
that causes my problem.<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Regards<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">//Ernst<o:p></o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 14:53 GMT&#43;02:00 StDenis, Tom =
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;:<o:p></o:p></span></p>
<div>
<div>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Does your tree have&nbsp;<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">2f3d686d0ee95332d8888169c7b6788bb2d9f5ad<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">780605db12c52f2c22d4d2cc05ceb7d2a9d55579<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">in it?&nbsp; Those are fixes for when the third ring were added.=
<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</=
o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" tar=
get=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 08:49<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Ernst Sj=F6strand<br>
<b>Subject:</b> [PATCH] amdgpu: Fix failing boot after support for third vc=
e ring</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck">My Fiji class Fury fails to boot after commit<br>
6f0359ff73076483902de0c17f9649bf55651e2a<br>
&quot;drm/amdgpu/vce3: add support for third vce ring&quot;<br>
This commits reverts the number of vce rings back to 2,<br>
but leaves the other changes intact.<br>
<br>
Signed-off-by: Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" ta=
rget=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 3f899e3..6f5eb64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -358,7 &#43;358,7 @@ static int vce_v3_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (A=
MDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vce.num_rings =3D 3;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;vce.num_rings =3D 2;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_set_ring_funcs(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_set_irq_funcs(ade=
v);<br>
-- <br>
2.7.4<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">___________________________=
____________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank" id=3D"m_-2167022505463390063m_7545045248063895902m_-81333347032=
98494421m_-1771598304858325824LPlnk959250">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a>
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div>
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
&quot;sans-serif&quot;;color:#3B5777"><a href=3D"https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decorat=
ion:none">amd-gfx
 Info Page - lists.freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"m_-2167022505463=
390063m_7545045248063895902m_-8133334703298494421m_-1771598304858325824LPMe=
tadata_14764495470460.18698958466014992">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666"><a href=3D"http://lists.freedesktop.org" target=3D"_=
blank">lists.freedesktop.org</a><o:p></o:p></span></p>
</div>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPDescription_14764495470460.6448197846508978">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666">To see the collection of prior postings to the list,=
 visit the amd-gfx Archives. Using amd-gfx: To post a message
 to all the list members, send email ...<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB169476FBE38ABF8A3A991604F7DF0MWHPR12MB1694namp_--

--===============1507784182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1507784182==--

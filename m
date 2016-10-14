From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce ring
Date: Fri, 14 Oct 2016 13:21:14 +0000
Message-ID: <CY4PR12MB1768FB1C0830FC368B671BC5F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1476449341-2673-1-git-send-email-ernstp@gmail.com>
 <CY4PR12MB1768CDAC43129C814D75DCE0F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=XdwL5AaZ=kJKQXWgcYPUYrCJd4SMXT9FH470Ei5_dqOA@mail.gmail.com>
 <CY4PR12MB1768287E6AD0257F6330C5CFF7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=VjQmmZtLb9h87jzm_Oha+NOLZ83JeYRreQzwsK7aCZTw@mail.gmail.com>
 <CAD=4a=VHdJ1WKE3XQmiSK+-M2NLfZq5N6kgU_J7tcjVmmz8vpg@mail.gmail.com>,
 <CAD=4a=XVD6dq7KWFtY9r5qS4saARoXvpqLcshX1L=Vibri7cLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0493849671=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD=4a=XVD6dq7KWFtY9r5qS4saARoXvpqLcshX1L=Vibri7cLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?Windows-1252?Q?Ernst_Sj=F6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0493849671==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768FB1C0830FC368B671BC5F7DF0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768FB1C0830FC368B671BC5F7DF0CY4PR12MB1768namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

You'd need


https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&id=
=3D9ab4662c313d25731e53cc4f044bddb9c506ca13

and

https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&id=
=3Dda00756f75422b04befae381e7e48d0cacf299f3


I'll let Alex speak for the drm-next branches since he manages them.


Tom


________________________________
From: Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, October 14, 2016 09:20
To: StDenis, Tom
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] amdgpu: Fix failing boot after support for third vce r=
ing

Means the drm pull request for 4.9 is broken then also, FYI.

2016-10-14 15:17 GMT+02:00 Ernst Sj=F6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:ernst=
p@gmail.com>>:
9d24b304abbe5380da1bc782b4460596e7cb1109
cherry-picks cleanly on drm-next-4.9-wip but then fails to build:

  CC [M]  drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:2: error: unknown field =91type=
=92 specified in initializer
  .type =3D AMDGPU_RING_TYPE_VCE,
  ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: warning: initialization makes=
 pointer from integer without a cast [-Wint-conversion]
  .type =3D AMDGPU_RING_TYPE_VCE,
          ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: note: (near initialization fo=
r =91vce_v3_0_ring_phys_funcs.get_rptr=92)
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:2: error: unknown field =91align_=
mask=92 specified in initializer
  .align_mask =3D 0xf,
  ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: warning: initialization makes=
 pointer from integer without a cast [-Wint-conversion]
  .align_mask =3D 0xf,
                ^
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: note: (near initialization fo=
r =91vce_v3_0_ring_phys_funcs.get_wptr=92)
drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:856:2: error: unknown field =91nop=92=
 specified in initializer
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








--_000_CY4PR12MB1768FB1C0830FC368B671BC5F7DF0CY4PR12MB1768namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>You'd need&nbsp;</p>
<p><br>
</p>
<p><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-nex=
t-4.7-wip&amp;id=3D9ab4662c313d25731e53cc4f044bddb9c506ca13" class=3D"OWAAu=
toLink" id=3D"LPlnk511980" previewremoved=3D"true">https://cgit.freedesktop=
.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&amp;id=3D9ab4662c313d25731e5=
3cc4f044bddb9c506ca13</a><br>
</p>
<p>and</p>
<p><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-nex=
t-4.7-wip&amp;id=3Dda00756f75422b04befae381e7e48d0cacf299f3" class=3D"OWAAu=
toLink" id=3D"LPlnk276724" previewremoved=3D"true">https://cgit.freedesktop=
.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&amp;id=3Dda00756f75422b04bef=
ae381e7e48d0cacf299f3</a><br>
</p>
<p><br>
</p>
<p>I'll let Alex speak for the drm-next branches since he manages them.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Ernst Sj=F6strand &lt=
;ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:20<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Means the drm pull request for 4.9 is broken then also, FY=
I.<br>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">2016-10-14 15:17 GMT&#43;02:00 Ernst Sj=F6strand=
 <span dir=3D"ltr">
&lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div>9d24b304abbe5380da1bc782b44605<wbr>96e7cb1109<br>
</div>
cherry-picks cleanly on drm-next-4.9-wip but then fails to build:<br>
<br>
&nbsp; CC [M]&nbsp; drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.o<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:854:2: error: unknown field =91t=
ype=92 specified in initializer<br>
&nbsp; .type =3D AMDGPU_RING_TYPE_VCE,<br>
&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:854:10: warning: initialization =
makes pointer from integer without a cast [-Wint-conversion]<br>
&nbsp; .type =3D AMDGPU_RING_TYPE_VCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:854:10: note: (near initializati=
on for =91vce_v3_0_ring_phys_funcs.get_<wbr>rptr=92)<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:855:2: error: unknown field =91a=
lign_mask=92 specified in initializer<br>
&nbsp; .align_mask =3D 0xf,<br>
&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:855:16: warning: initialization =
makes pointer from integer without a cast [-Wint-conversion]<br>
&nbsp; .align_mask =3D 0xf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:855:16: note: (near initializati=
on for =91vce_v3_0_ring_phys_funcs.get_<wbr>wptr=92)<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:856:2: error: unknown field =91n=
op=92 specified in initializer<br>
&nbsp; .nop =3D VCE_CMD_NO_OP,<br>
&nbsp; ^<br>
<br>
</div>
<div class=3D"HOEnZb">
<div class=3D"h5">
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">2016-10-14 15:15 GMT&#43;02:00 Ernst Sj=F6strand=
 <span dir=3D"ltr">
&lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div>
<div>
<div>
<div>
<div>
<div>
<div>I'm testing both drm-next-4.9 and drm-next-4.9-wip from ~agd5f.<br>
</div>
I think the problem is in drm-next now also.<br>
</div>
They all have<br>
6f0359f drm/amdgpu/vce3: add support for third vce ring<br>
75c6548 drm/amdgpu: track the number of vce rings<br>
<br>
</div>
But not<br>
9d24b30 drm/amdgpu: fix broken VCE startup in phys mode<br>
</div>
which only exists in amd-staging-4.7<br>
</div>
(What does 4.7 mean in this context... ?)<br>
<br>
</div>
Regards<span class=3D"m_-2167022505463390063HOEnZb"><font color=3D"#888888"=
><br>
</font></span></div>
<span class=3D"m_-2167022505463390063HOEnZb"><font color=3D"#888888">//Erns=
t<br>
<div>
<div>
<div><br>
</div>
</div>
</div>
</font></span></div>
<div class=3D"m_-2167022505463390063HOEnZb">
<div class=3D"m_-2167022505463390063h5">
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">2016-10-14 15:07 GMT&#43;02:00 StDenis, Tom <spa=
n dir=3D"ltr">
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; font-family:=
Calibri,Arial,Helvetica,sans-serif">
<p>Do you have&nbsp;<a href=3D"https://cgit.freedesktop.org/~agd5f/linux/co=
mmit/?h=3Ddrm-next-4.7-wip&amp;id=3D9d24b304abbe5380da1bc782b4460596e7cb110=
9" class=3D"m_-2167022505463390063m_7545045248063895902m_-81333347032984944=
21OWAAutoLink" id=3D"m_-2167022505463390063m_7545045248063895902m_-81333347=
03298494421LPlnk640528" target=3D"_blank">https://cgit.freedesktop.<wbr>org=
/~agd5f/linux/commit/?h=3Ddrm<wbr>-next-4.7-wip&amp;id=3D9d24b304abbe5<wbr>=
380da1bc782b4460596e7cb1109</a>&nbsp;as
 well?</p>
<p><br>
</p>
<p>I've booted the tip of our staging-4.7 branch with a FIJI device (FURY) =
and was able to play videos (vdpau) and normal GL apps.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1divRplyFwdMsg" dir=3D"ltr">
<font color=3D"#000000" face=3D"Calibri, sans-serif" style=3D"font-size:11p=
t"><b>From:</b> Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" t=
arget=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:05<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"m_-2167022505463390063m_7545045248063895902h5">
<div>
<div dir=3D"ltr">
<div>Yes, the&nbsp; 6f0359ff73076483902de0c17f9649<wbr>bf55651e2a I'm refer=
ring to is the same as
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
<div class=3D"gmail_quote">2016-10-14 14:53 GMT&#43;02:00 StDenis, Tom <spa=
n dir=3D"ltr">
&lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis@am=
d.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824divtagdefaultwrapper" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Does your tree have&nbsp;</p>
<p><br>
</p>
<p><span>2f3d686d0ee95332d8888169c7b678<wbr>8bb2d9f5ad</span><br>
</p>
<p><span><span>780605db12c52f2c22d4d2cc05ceb7<wbr>d2a9d55579</span><br>
</span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>in it?&nbsp; Those are fixes for when the third ring were ad=
ded.</span></span></p>
<p><span><span><br>
</span></span></p>
<p><span><span>Tom</span></span></p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr style=3D"display:inline-block; width:98%">
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824x_divRplyFwdMsg" dir=3D"ltr">
<font color=3D"#000000" face=3D"Calibri, sans-serif" style=3D"font-size:11p=
t"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org<wbr>ktop.org</a>&=
gt; on behalf of Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 08:49<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Ernst Sj=F6strand<br>
<b>Subject:</b> [PATCH] amdgpu: Fix failing boot after support for third vc=
e ring</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849=
4421m_-1771598304858325824PlainText">
<div>
<div class=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849=
4421h5">
My Fiji class Fury fails to boot after commit<br>
6f0359ff73076483902de0c17f9649<wbr>bf55651e2a<br>
&quot;drm/amdgpu/vce3: add support for third vce ring&quot;<br>
This commits reverts the number of vce rings back to 2,<br>
but leaves the other changes intact.<br>
<br>
Signed-off-by: Ernst Sj=F6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" ta=
rget=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vc<wbr>e_v3_0.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/v<wbr>ce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/v<wbr>ce_v3_0.c<br>
index 3f899e3..6f5eb64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/v<wbr>ce_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/v<wbr>ce_v3_0.c<br>
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
2.7.4<br>
<br>
</div>
</div>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"m_=
-2167022505463390063m_7545045248063895902m_-8133334703298494421m_-177159830=
4858325824LPlnk959250" target=3D"_blank">https://lists.freedesktop.org/<wbr=
>mailman/listinfo/amd-gfx</a>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPBorder_GT_14764495470470.9881266530783932" style=
=3D"margin-bottom:20px; overflow:auto; width:100%; text-indent:0px">
<table id=3D"m_-2167022505463390063m_7545045248063895902m_-8133334703298494=
421m_-1771598304858325824LPContainer_14764495470450.11026149163994892" cell=
spacing=3D"0" style=3D"width:90%; background-color:rgb(255,255,255); overfl=
ow:auto; padding-top:20px; padding-bottom:20px; margin-top:20px; border-top=
:1px dotted rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"m_-2167022505463390063m_7545045248063895902m_-8133334703298494421=
m_-1771598304858325824TextCell_14764495470460.7288026297683508" colspan=3D"=
2" style=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPRemovePreviewContainer_14764495470460.164276900461=
59027">
</div>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPTitle_14764495470460.741636132433581" style=3D"col=
or:rgb(59,87,119); font-weight:normal; font-size:21px; font-family:wf_segoe=
-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&quot;Segoe=
 UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line-height:21px">
<a id=3D"m_-2167022505463390063m_7545045248063895902m_-8133334703298494421m=
_-1771598304858325824LPUrlAnchor_14764495470460.2698087919077241" href=3D"h=
ttps://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" st=
yle=3D"text-decoration:none">amd-gfx Info
 Page - lists.freedesktop.org</a></div>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPMetadata_14764495470460.18698958466014992" style=
=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight:normal; font-=
family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"m_-2167022505463390063m_7545045248063895902m_-813333470329849442=
1m_-1771598304858325824LPDescription_14764495470460.6448197846508978" style=
=3D"display:block; color:rgb(102,102,102); font-weight:normal; font-family:=
wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,s=
ans-serif; font-size:14px; line-height:20px; max-height:100px; overflow:hid=
den">
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
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768FB1C0830FC368B671BC5F7DF0CY4PR12MB1768namp_--

--===============0493849671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0493849671==--

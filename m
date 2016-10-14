From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] amdgpu: Fix failing boot after support for third vce ring
Date: Fri, 14 Oct 2016 16:05:58 +0200
Message-ID: <CAD=4a=U=FmHfSSv=TbhKusb+_DzPRQWNdh8orrtoXqac0tBVZQ@mail.gmail.com>
References: <1476449341-2673-1-git-send-email-ernstp@gmail.com>
 <CY4PR12MB1768CDAC43129C814D75DCE0F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=XdwL5AaZ=kJKQXWgcYPUYrCJd4SMXT9FH470Ei5_dqOA@mail.gmail.com>
 <CY4PR12MB1768287E6AD0257F6330C5CFF7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <CAD=4a=VjQmmZtLb9h87jzm_Oha+NOLZ83JeYRreQzwsK7aCZTw@mail.gmail.com>
 <CAD=4a=VHdJ1WKE3XQmiSK+-M2NLfZq5N6kgU_J7tcjVmmz8vpg@mail.gmail.com>
 <CAD=4a=XVD6dq7KWFtY9r5qS4saARoXvpqLcshX1L=Vibri7cLA@mail.gmail.com>
 <CY4PR12MB1768FB1C0830FC368B671BC5F7DF0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <MWHPR12MB169476FBE38ABF8A3A991604F7DF0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0024459867=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB169476FBE38ABF8A3A991604F7DF0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0024459867==
Content-Type: multipart/alternative; boundary=001a114087a8cb1945053ed3b918

--001a114087a8cb1945053ed3b918
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

next-4.9 and wip are the broken branches for me so something is wrong. I
could cherry pick the patch Tom mentioned and got a delta so I don't think
you have it.

Den 14 okt. 2016 3:49 em skrev "Deucher, Alexander" <
Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>:

> All of those patches are integrated:
>
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&id=
=3D
> 57da26e4c4c1c7cc042aba1925813fea7413dbeb
>
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&id=
=3D
> d7ca7ab8259f43473bc387dda2a5b84aeb049961
>
>
>
>
>
> *From:* amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On Behalf
> Of *StDenis, Tom
> *Sent:* Friday, October 14, 2016 9:21 AM
> *To:* Ernst Sj=C3=B6strand
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] amdgpu: Fix failing boot after support for third
> vce ring
>
>
>
> You'd need
>
>
>
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&id=
=3D
> 9ab4662c313d25731e53cc4f044bddb9c506ca13
>
> and
>
> https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.7-wip&id=
=3D
> da00756f75422b04befae381e7e48d0cacf299f3
>
>
>
> I'll let Alex speak for the drm-next branches since he manages them.
>
>
>
> Tom
>
>
> ------------------------------
>
> *From:* Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, October 14, 2016 09:20
> *To:* StDenis, Tom
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] amdgpu: Fix failing boot after support for third
> vce ring
>
>
>
> Means the drm pull request for 4.9 is broken then also, FYI.
>
>
>
> 2016-10-14 15:17 GMT+02:00 Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
> 9d24b304abbe5380da1bc782b4460596e7cb1109
>
> cherry-picks cleanly on drm-next-4.9-wip but then fails to build:
>
>   CC [M]  drivers/gpu/drm/amd/amdgpu/vce_v3_0.o
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:2: error: unknown field =E2=80=
=98type=E2=80=99
> specified in initializer
>   .type =3D AMDGPU_RING_TYPE_VCE,
>   ^
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: warning: initialization
> makes pointer from integer without a cast [-Wint-conversion]
>   .type =3D AMDGPU_RING_TYPE_VCE,
>           ^
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:854:10: note: (near initialization
> for =E2=80=98vce_v3_0_ring_phys_funcs.get_rptr=E2=80=99)
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:2: error: unknown field
> =E2=80=98align_mask=E2=80=99 specified in initializer
>   .align_mask =3D 0xf,
>   ^
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: warning: initialization
> makes pointer from integer without a cast [-Wint-conversion]
>   .align_mask =3D 0xf,
>                 ^
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:855:16: note: (near initialization
> for =E2=80=98vce_v3_0_ring_phys_funcs.get_wptr=E2=80=99)
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:856:2: error: unknown field =E2=80=
=98nop=E2=80=99
> specified in initializer
>   .nop =3D VCE_CMD_NO_OP,
>   ^
>
>
>
> 2016-10-14 15:15 GMT+02:00 Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>
> I'm testing both drm-next-4.9 and drm-next-4.9-wip from ~agd5f.
>
> I think the problem is in drm-next now also.
>
> They all have
> 6f0359f drm/amdgpu/vce3: add support for third vce ring
> 75c6548 drm/amdgpu: track the number of vce rings
>
> But not
> 9d24b30 drm/amdgpu: fix broken VCE startup in phys mode
>
> which only exists in amd-staging-4.7
>
> (What does 4.7 mean in this context... ?)
>
> Regards
>
> //Ernst
>
>
>
>
>
> 2016-10-14 15:07 GMT+02:00 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>:
>
> Do you have https://cgit.freedesktop.org/~agd5f/linux/commit/?h=3D
> drm-next-4.7-wip&id=3D9d24b304abbe5380da1bc782b4460596e7cb1109 as well?
>
>
>
> I've booted the tip of our staging-4.7 branch with a FIJI device (FURY)
> and was able to play videos (vdpau) and normal GL apps.
>
>
>
> Tom
>
>
> ------------------------------
>
> *From:* Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, October 14, 2016 09:05
> *To:* StDenis, Tom
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] amdgpu: Fix failing boot after support for third
> vce ring
>
>
>
> Yes, the  6f0359ff73076483902de0c17f9649bf55651e2a I'm referring to is
> the same as
> 780605db12c52f2c22d4d2cc05ceb7d2a9d55579 (only exists in amd-staging).
>
> So the last of those two commits is the one that causes my problem.
>
>
>
> Regards
>
> //Ernst
>
>
>
> 2016-10-14 14:53 GMT+02:00 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>:
>
> Does your tree have
>
>
>
> 2f3d686d0ee95332d8888169c7b6788bb2d9f5ad
>
> 780605db12c52f2c22d4d2cc05ceb7d2a9d55579
>
>
>
> in it?  Those are fixes for when the third ring were added.
>
>
>
> Tom
>
>
> ------------------------------
>
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, October 14, 2016 08:49
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Ernst Sj=C3=B6strand
> *Subject:* [PATCH] amdgpu: Fix failing boot after support for third vce
> ring
>
>
>
> My Fiji class Fury fails to boot after commit
> 6f0359ff73076483902de0c17f9649bf55651e2a
> "drm/amdgpu/vce3: add support for third vce ring"
> This commits reverts the number of vce rings back to 2,
> but leaves the other changes intact.
>
> Signed-off-by: Ernst Sj=C3=B6strand <ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 3f899e3..6f5eb64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -358,7 +358,7 @@ static int vce_v3_0_early_init(void *handle)
>              (AMDGPU_VCE_HARVEST_VCE0 | AMDGPU_VCE_HARVEST_VCE1))
>                  return -ENOENT;
>
> -       adev->vce.num_rings =3D 3;
> +       adev->vce.num_rings =3D 2;
>
>          vce_v3_0_set_ring_funcs(adev);
>          vce_v3_0_set_irq_funcs(adev);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> amd-gfx Info Page - lists.freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>
> lists.freedesktop.org
>
> To see the collection of prior postings to the list, visit the amd-gfx
> Archives. Using amd-gfx: To post a message to all the list members, send
> email ...
>
>
>
>
>
>
>
>
>
>
>

--001a114087a8cb1945053ed3b918
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">next-4.9 and wip are the broken branches for me so something=
 is wrong. I could cherry pick the patch Tom mentioned and got a delta so I=
 don&#39;t think you have it. </p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">Den 14 okt. 2016 =
3:49 em skrev &quot;Deucher, Alexander&quot; &lt;<a href=3D"mailto:Alexande=
r.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;:<br type=3D"attributio=
n"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"m_2020318726477089758WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">All of those patches are =
integrated:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><a href=3D"https://cgit.f=
reedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&amp;id=3D57da26e4c=
4c1c7cc042aba1925813fea7413dbeb" target=3D"_blank">https://cgit.freedesktop=
.org/~<wbr>agd5f/linux/commit/?h=3Ddrm-<wbr>next-4.9-wip&amp;id=3D<wbr>57da=
26e4c4c1c7cc042aba1925813f<wbr>ea7413dbeb</a><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><a href=3D"https://cgit.f=
reedesktop.org/~agd5f/linux/commit/?h=3Ddrm-next-4.9-wip&amp;id=3Dd7ca7ab82=
59f43473bc387dda2a5b84aeb049961" target=3D"_blank">https://cgit.freedesktop=
.org/~<wbr>agd5f/linux/commit/?h=3Ddrm-<wbr>next-4.9-wip&amp;id=3D<wbr>d7ca=
7ab8259f43473bc387dda2a5b8<wbr>4aeb049961</a><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"=
_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Friday, October 14, 2016 9:21 AM<br>
<b>To:</b> Ernst Sj=C3=B6strand<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div id=3D"m_2020318726477089758m_-2167022505463390063m_7545045248063895902=
m_-8133334703298494421m_-1771598304858325824LPMetadata_14764495470460.18698=
958466014992">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">You&#39;d need=C2=A0<u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=
=3Ddrm-next-4.7-wip&amp;id=3D9ab4662c313d25731e53cc4f044bddb9c506ca13" id=
=3D"m_2020318726477089758LPlnk511980" target=3D"_blank">https://cgit.freede=
sktop.org/~<wbr>agd5f/linux/commit/?h=3Ddrm-<wbr>next-4.7-wip&amp;id=3D<wbr=
>9ab4662c313d25731e53cc4f044bdd<wbr>b9c506ca13</a><u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">and<u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><a href=3D"https://cgit.freedesktop.org/~agd5f/linux/commit/?h=
=3Ddrm-next-4.7-wip&amp;id=3Dda00756f75422b04befae381e7e48d0cacf299f3" id=
=3D"m_2020318726477089758LPlnk276724" target=3D"_blank">https://cgit.freede=
sktop.org/~<wbr>agd5f/linux/commit/?h=3Ddrm-<wbr>next-4.7-wip&amp;id=3D<wbr=
>da00756f75422b04befae381e7e48d<wbr>0cacf299f3</a><u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I&#39;ll let Alex speak for the drm-next branches since he manag=
es them.<u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><u></u>=C2=A0=
<u></u></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"m_2020318726477089758divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail.c=
om" target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:20<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:black">
<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">=C2=A0<u></u><u></u></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Means the drm pull request for 4.9 is broken=
 then also, FYI.<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 15:17 GMT+02:00 Ernst Sj=C3=B6str=
and &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ernstp@gmail.=
com</a>&gt;:<u></u><u></u></span></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">9d24b304abbe5380da1bc782b44605<wbr>96e7cb110=
9<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">cherry-picks =
cleanly on drm-next-4.9-wip but then fails to build:<br>
<br>
=C2=A0 CC [M]=C2=A0 drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.o<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:854:2: error: unknown field =E2=
=80=98type=E2=80=99 specified in initializer<br>
=C2=A0 .type =3D AMDGPU_RING_TYPE_VCE,<br>
=C2=A0 ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:854:10: warning: initialization =
makes pointer from integer without a cast [-Wint-conversion]<br>
=C2=A0 .type =3D AMDGPU_RING_TYPE_VCE,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:854:10: note: (near initializati=
on for =E2=80=98vce_v3_0_ring_phys_funcs.get_<wbr>rptr=E2=80=99)<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:855:2: error: unknown field =E2=
=80=98align_mask=E2=80=99 specified in initializer<br>
=C2=A0 .align_mask =3D 0xf,<br>
=C2=A0 ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:855:16: warning: initialization =
makes pointer from integer without a cast [-Wint-conversion]<br>
=C2=A0 .align_mask =3D 0xf,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:855:16: note: (near initializati=
on for =E2=80=98vce_v3_0_ring_phys_funcs.get_<wbr>wptr=E2=80=99)<br>
drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c:856:2: error: unknown field =E2=
=80=98nop=E2=80=99 specified in initializer<br>
=C2=A0 .nop =3D VCE_CMD_NO_OP,<br>
=C2=A0 ^<u></u><u></u></span></p>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 15:15 GMT+02:00 Ernst Sj=C3=B6str=
and &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">ernstp@gmail.=
com</a>&gt;:<u></u><u></u></span></p>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">I&#39;m testing both drm-next-4.9 and drm-ne=
xt-4.9-wip from ~agd5f.<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">I think the problem is in drm-next now also.=
<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">They all have=
<br>
6f0359f drm/amdgpu/vce3: add support for third vce ring<br>
75c6548 drm/amdgpu: track the number of vce rings<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">But not<br>
9d24b30 drm/amdgpu: fix broken VCE startup in phys mode<u></u><u></u></span=
></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">which only exists in amd-staging-4.7<u></u><=
u></u></span></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">(What does 4.=
7 mean in this context... ?)<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Regards<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><span class=3D"m_2020318726477089758m-21670225054633=
90063hoenzb"><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:#888888">//Ernst</span><span style=3D"color:#888888"><u></u><=
u></u></span></span></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
</div>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 15:07 GMT+02:00 StDenis, Tom &lt;=
<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis-urvtwAKJhsc@public.gmane.org=
m</a>&gt;:<u></u><u></u></span></p>
<div>
<div>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Do you have=C2=A0<a href=3D"https://cgit.freedesktop.org/~agd5f/=
linux/commit/?h=3Ddrm-next-4.7-wip&amp;id=3D9d24b304abbe5380da1bc782b446059=
6e7cb1109" id=3D"m_2020318726477089758m_-2167022505463390063m_7545045248063=
895902m_-8133334703298494421LPlnk640528" target=3D"_blank">https://cgit.fre=
edesktop.<wbr>org/~agd5f/linux/commit/?h=3D<wbr>drm-next-4.7-wip&amp;id=3D<=
wbr>9d24b304abbe5380da1bc782b44605<wbr>96e7cb1109</a>=C2=A0as
 well?<u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">I&#39;ve booted the tip of our staging-4.7 branch with a FIJI de=
vice (FURY) and was able to play videos (vdpau) and normal GL apps.<u></u><=
u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><u></u>=C2=A0=
<u></u></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"m_2020318726477089758m_-2167022505463390063m_7545045248063895902=
m_-8133334703298494421divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail.c=
om" target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 09:05<br>
<b>To:</b> StDenis, Tom<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH] amdgpu: Fix failing boot after support for thir=
d vce ring</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:black">
<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">=C2=A0<u></u><u></u></span></p>
</div>
</div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Yes, the=C2=A0 6f0359ff73076483902de0c17f964=
9<wbr>bf55651e2a I&#39;m referring to is the same as
<br>
780605db12c52f2c22d4d2cc05ceb7<wbr>d2a9d55579 (only exists in amd-staging).=
<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">So the last of those two commits is the one =
that causes my problem.<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">Regards<u></u><u></u></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">//Ernst<u></u><u></u></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">2016-10-14 14:53 GMT+02:00 StDenis, Tom &lt;=
<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis-urvtwAKJhsc@public.gmane.org=
m</a>&gt;:<u></u><u></u></span></p>
<div>
<div>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Does your tree have=C2=A0<u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">2f3d686d0ee95332d8888169c7b678<wbr>8bb2d9f5ad<u></u><u></u></spa=
n></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">780605db12c52f2c22d4d2cc05ceb7<wbr>d2a9d55579<u></u><u></u></spa=
n></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">in it?=C2=A0 Those are fixes for when the third ring were added.=
<u></u><u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black"><u></u>=C2=A0<u></u></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Tom<u></u><u></u></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><u></u>=C2=A0=
<u></u></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"m_2020318726477089758m_-2167022505463390063m_7545045248063895902=
m_-8133334703298494421m_-1771598304858325824x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org" target=3D"_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a=
>&gt;
 on behalf of Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, October 14, 2016 08:49<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Ernst Sj=C3=B6strand<br>
<b>Subject:</b> [PATCH] amdgpu: Fix failing boot after support for third vc=
e ring</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:black">
<u></u><u></u></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">=C2=A0<u></u><u></u></span></p>
</div>
</div>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck">My Fiji class Fury fails to boot after commit<br>
6f0359ff73076483902de0c17f9649<wbr>bf55651e2a<br>
&quot;drm/amdgpu/vce3: add support for third vce ring&quot;<br>
This commits reverts the number of vce rings back to 2,<br>
but leaves the other changes intact.<br>
<br>
Signed-off-by: Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"=
 target=3D"_blank">ernstp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/<wbr>vce_v3_0.c<br>
index 3f899e3..6f5eb64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>vce_v3_0.c<br>
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
2.7.4<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">___________________________=
___<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"m_=
2020318726477089758m_-2167022505463390063m_7545045248063895902m_-8133334703=
298494421m_-1771598304858325824LPlnk959250" target=3D"_blank">https://lists=
.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
<u></u><u></u></span></p>
<div style=3D"margin-bottom:15.0pt">
<table class=3D"m_2020318726477089758MsoNormalTable" border=3D"1" cellspaci=
ng=3D"0" cellpadding=3D"0" width=3D"90%" style=3D"width:90.0%;background:wh=
ite;border-top:dotted #c8c8c8 1.0pt;border-left:none;border-bottom:dotted #=
c8c8c8 1.0pt;border-right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div>
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt"><span style=3D"font-size=
:16.0pt;font-family:&quot;Segoe UI Light&quot;,&quot;sans-serif&quot;;color=
:#3b5777"><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" target=3D"_blank"><span style=3D"text-decoration:none">amd-gfx
 Info Page - lists.freedesktop.org</span></a><u></u><u></u></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"m_20203187264770=
89758m_-2167022505463390063m_7545045248063895902m_-8133334703298494421m_-17=
71598304858325824LPMetadata_14764495470460.18698958466014992">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666"><a href=3D"http://lists.freedesktop.org" target=3D"_=
blank">lists.freedesktop.org</a><u></u><u></u></span></p>
</div>
<div id=3D"m_2020318726477089758m_-2167022505463390063m_7545045248063895902=
m_-8133334703298494421m_-1771598304858325824LPDescription_14764495470460.64=
48197846508978">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666">To see the collection of prior postings to the list,=
 visit the amd-gfx Archives. Using amd-gfx: To post a message
 to all the list members, send email ...<u></u><u></u></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black"><u></u>=C2=A0<u></u></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--001a114087a8cb1945053ed3b918--

--===============0024459867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0024459867==--

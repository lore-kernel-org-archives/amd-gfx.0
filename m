From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ
Date: Thu, 19 Jul 2018 12:53:37 -0400
Message-ID: <CADnq5_P=MunRPuEyqN91c0nj6DdRo7cXKw9u+TTweZKG7zJ1iw@mail.gmail.com>
References: <1531990018-29711-1-git-send-email-rex.zhu@amd.com>
 <1531990018-29711-2-git-send-email-rex.zhu@amd.com>
 <CADnq5_OiAsxsCN3KiqOggwj_vgFXDb_J7a7_GVm8GXEsWNv7RA@mail.gmail.com>
 <CY4PR12MB1687C48AD2DAAB101BC823B6FB520@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="00000000000051973105715d0530"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687C48AD2DAAB101BC823B6FB520-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--00000000000051973105715d0530
Content-Type: multipart/alternative; boundary="00000000000051972d05715d052e"

--00000000000051972d05715d052e
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 19, 2018 at 11:14 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:

> >We also need to power it back up in hw_fini and suspend and then power
> >it back down in resume.
>
> Yes, this logic will be added in acp block.
> In this patch, we only power down acp when it was not used and have no
> inpact wen s3.
>

But I think when the asic comes out of S3/S4, the ACP block will be powered
up again so it will have to be powered down again to avoid using power
after resume.  So if the platform uses AZ rather than ACP, we need to
handle that case and to power ACP back up on hw_fini() in case the driver
gets reloaded.  S4 works similarly.  Something like the attached patch.

Alex



>
> Best Regards
> Rex
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, July 19, 2018 9:56 PM
> *To:* Zhu, Rex
> *Cc:* amd-gfx list
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ
>
> On Thu, Jul 19, 2018 at 4:46 AM, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> > if board uses AZ rather than ACP, we power down acp
> > through smu to save power.
> >
>
> We also need to power it back up in hw_fini and suspend and then power
> it back down in resume.
>
> Alex
>
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > index 71efcf3..4e18a88 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> > @@ -35,6 +35,7 @@
> >
> >  #include "acp_gfx_if.h"
> >
> > +
> >  #define ACP_TILE_ON_MASK                       0x03
> >  #define ACP_TILE_OFF_MASK                      0x02
> >  #define ACP_TILE_ON_RETAIN_REG_MASK            0x1f
> > @@ -289,11 +290,12 @@ static int acp_hw_init(void *handle)
> >         r = amd_acp_hw_init(adev->acp.cgs_device,
> >                             ip_block->version->major,
> ip_block->version->minor);
> >         /* -ENODEV means board uses AZ rather than ACP */
> > -       if (r == -ENODEV)
> > +       if (r == -ENODEV) {
> > +               amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_ACP, true);
> >                 return 0;
> > -       else if (r)
> > +       } else if (r) {
> >                 return r;
> > -
> > +       }
> >         if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
> >                 return -EINVAL;
> >
> > --
> > 1.9.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following
> form. Use of all freedesktop.org lists is subject to our Code of Conduct.
>
>
>

--00000000000051972d05715d052e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
On Thu, Jul 19, 2018 at 11:14 AM, Zhu, Rex <span dir=3D"ltr">&lt;<a href=3D=
"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div id=3D"m_-5529052118359428029divtagdefaultwrapper" style=3D"font-size:1=
2pt;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr"><sp=
an class=3D"">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family:Calibr=
i,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe =
UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emo=
ji&quot;,EmojiSymbols;font-size:14.6667px">&gt;We also need to power
 it back up in hw_fini and suspend and then power</span><br style=3D"font-f=
amily:Calibri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,=
&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot=
;Android Emoji&quot;,EmojiSymbols;font-size:14.6667px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;App=
le Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe =
UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols;font-size:14.6667px"=
>&gt;it back down in resume.</span><br>
</p>
<div><br>
</div></span>
Yes, this logic will be added in acp block.
<div>In this patch, we only power down acp when it=C2=A0was not used and ha=
ve no inpact wen s3.</div></div></div></blockquote><div><br></div><div>But =
I think when the asic comes out of S3/S4, the ACP block will be powered up =
again so it will have to be powered down again to avoid using power after r=
esume.=C2=A0 So if the platform uses AZ rather than ACP, we need to handle =
that case and to power ACP back up on hw_fini() in case the driver gets rel=
oaded.=C2=A0 S4 works similarly.=C2=A0 Something like the attached patch.<b=
r></div><div><br></div><div>Alex<br></div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div id=3D"m_-55290521183594=
28029divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font-famil=
y:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<div><br>
</div>
<div>Best Regards</div>
<div>Rex<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-5529052118359428029divRplyFwdMsg" dir=3D"ltr"><font style=3D"=
font-size:11pt" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b>=
 Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank=
">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, July 19, 2018 9:56 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ=
</font>
<div>=C2=A0</div>
</div>
<div class=3D"m_-5529052118359428029BodyFragment"><font size=3D"2"><span st=
yle=3D"font-size:11pt">
<div class=3D"m_-5529052118359428029PlainText"><div><div class=3D"h5">On Th=
u, Jul 19, 2018 at 4:46 AM, Rex Zhu &lt;<a href=3D"mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">rex.zhu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; if board uses AZ rather than ACP, we power down acp<br>
&gt; through smu to save power.<br>
&gt;<br>
<br>
We also need to power it back up in hw_fini and suspend and then power<br>
it back down in resume.<br>
<br>
Alex<br>
<br>
&gt; Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c | 8 +++++---<br>
&gt;=C2=A0 1 file changed, 5 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c b/drivers/gp=
u/drm/amd/amdgpu/<wbr>amdgpu_acp.c<br>
&gt; index 71efcf3..4e18a88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c<br>
&gt; @@ -35,6 +35,7 @@<br>
&gt;<br>
&gt;=C2=A0 #include &quot;acp_gfx_if.h&quot;<br>
&gt;<br>
&gt; +<br>
&gt;=C2=A0 #define ACP_TILE_ON_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 0x03<br>
&gt;=C2=A0 #define ACP_TILE_OFF_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x02<br>
&gt;=C2=A0 #define ACP_TILE_ON_RETAIN_REG_MASK=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x1f<br>
&gt; @@ -289,11 +290,12 @@ static int acp_hw_init(void *handle)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amd_acp_hw_init(=
adev-&gt;acp.cgs_<wbr>device,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ip_block-&gt;version-&gt;major, ip_block-&gt;versi=
on-&gt;minor);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* -ENODEV means board=
 uses AZ rather than ACP */<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r =3D=3D -ENODEV)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r =3D=3D -ENODEV) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 amdgpu_dpm_set_powergating_by_<wbr>smu(adev, AMD_IP_BLOCK_T=
YPE_ACP, true);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (r)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (r) {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r;<br>
&gt; -<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev-&gt;rmmio_siz=
e =3D=3D 0 || adev-&gt;rmmio_size &lt; 0x5289)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;<br>
&gt;<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"m_-5529052118359428029LPlnk998837" class=3D"m_-5529052118359428029OWAAu=
toLink" target=3D"_blank">
https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</div></div><div id=3D"m_-5529052118359428029LPBorder_GT_15320131028380.702=
754859637317" style=3D"margin-bottom:20px;overflow:auto;width:100%;text-ind=
ent:0px">
<table id=3D"m_-5529052118359428029LPContainer_15320131028280.1025073489385=
282" style=3D"width:90%;background-color:rgb(255,255,255);overflow:auto;pad=
ding-top:20px;padding-bottom:20px;margin-top:20px;border-top:1px dotted rgb=
(200,200,200);border-bottom:1px dotted rgb(200,200,200)" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td id=3D"m_-5529052118359428029TextCell_15320131028320.9917042135546368" c=
olspan=3D"2" style=3D"vertical-align:top;padding:0px;display:table-cell">
<div id=3D"m_-5529052118359428029LPRemovePreviewContainer_15320131028320.02=
4263722967099"></div>
<div id=3D"m_-5529052118359428029LPTitle_15320131028320.9687962596936737" s=
tyle=3D"color:rgb(0,120,215);font-weight:normal;font-size:21px;font-family:=
wf_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quot;,&qu=
ot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;line-height:=
21px">
<a id=3D"m_-5529052118359428029LPUrlAnchor_15320131028340.4538000273988081"=
 href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" style=3D"t=
ext-decoration:none" target=3D"_blank">amd-gfx Info Page - freedesktop.org<=
/a></div>
<div id=3D"m_-5529052118359428029LPMetadata_15320131028350.1322910965297083=
9" style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:normal;=
font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif;font-size:14px;line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"m_-5529052118359428029LPDescription_15320131028370.6585869579202=
912" style=3D"display:block;color:rgb(102,102,102);font-weight:normal;font-=
family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif;font-size:14px;line-height:20px;max-height:100px;overflow:=
hidden">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all <a href=3D"http://freedesktop.org" target=3D"_blank">freede=
sktop.org</a> lists is subject to our Code of Conduct.</div>
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
</div>
</div>

</blockquote></div><br></div></div>

--00000000000051972d05715d052e--

--00000000000051973105715d0530
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-Power-down-acp-if-board-uses-AZ-v2.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Power-down-acp-if-board-uses-AZ-v2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjssoe330

RnJvbSA3M2Y0NjY5YTYwZjBkZWYxYzVkYzYxZjk5YTIwMWY4OGM2ZDBlNTI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IFRodSwg
MTkgSnVsIDIwMTggMTE6NDg6MzYgLTA1MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1OiBQ
b3dlciBkb3duIGFjcCBpZiBib2FyZCB1c2VzIEFaICh2MikKCmlmIGJvYXJkIHVzZXMgQVogcmF0
aGVyIHRoYW4gQUNQLCB3ZSBwb3dlciBkb3duIGFjcAp0aHJvdWdoIHNtdSB0byBzYXZlIHBvd2Vy
LgoKdjI6IGhhbmRsZSBTMy9TNCBhbmQgaHdfZmluaSAoQWxleCkKClNpZ25lZC1vZmYtYnk6IFJl
eCBaaHUgPFJleC5aaHVAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hY3AuYyB8IDIwICsrKysrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfYWNwLmMKaW5kZXggNzFlZmNmMzhmMTFiLi5kNGQxNzM4ZGEzYjYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3AuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMKQEAgLTI4OSwxMCArMjg5LDEyIEBAIHN0YXRp
YyBpbnQgYWNwX2h3X2luaXQodm9pZCAqaGFuZGxlKQogCXIgPSBhbWRfYWNwX2h3X2luaXQoYWRl
di0+YWNwLmNnc19kZXZpY2UsCiAJCQkgICAgaXBfYmxvY2stPnZlcnNpb24tPm1ham9yLCBpcF9i
bG9jay0+dmVyc2lvbi0+bWlub3IpOwogCS8qIC1FTk9ERVYgbWVhbnMgYm9hcmQgdXNlcyBBWiBy
YXRoZXIgdGhhbiBBQ1AgKi8KLQlpZiAociA9PSAtRU5PREVWKQorCWlmIChyID09IC1FTk9ERVYp
IHsKKwkJYW1kZ3B1X2RwbV9zZXRfcG93ZXJnYXRpbmdfYnlfc211KGFkZXYsIEFNRF9JUF9CTE9D
S19UWVBFX0FDUCwgdHJ1ZSk7CiAJCXJldHVybiAwOwotCWVsc2UgaWYgKHIpCisJfSBlbHNlIGlm
IChyKSB7CiAJCXJldHVybiByOworCX0KIAogCWlmIChhZGV2LT5ybW1pb19zaXplID09IDAgfHwg
YWRldi0+cm1taW9fc2l6ZSA8IDB4NTI4OSkKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC00OTcsOCAr
NDk5LDEwIEBAIHN0YXRpYyBpbnQgYWNwX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogCXN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCiAJ
LyogcmV0dXJuIGVhcmx5IGlmIG5vIEFDUCAqLwotCWlmICghYWRldi0+YWNwLmFjcF9jZWxsKQor
CWlmICghYWRldi0+YWNwLmFjcF9jZWxsKSB7CisJCWFtZGdwdV9kcG1fc2V0X3Bvd2VyZ2F0aW5n
X2J5X3NtdShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9BQ1AsIGZhbHNlKTsKIAkJcmV0dXJuIDA7
CisJfQogCiAJLyogQXNzZXJ0IFNvZnQgcmVzZXQgb2YgQUNQICovCiAJdmFsID0gY2dzX3JlYWRf
cmVnaXN0ZXIoYWRldi0+YWNwLmNnc19kZXZpY2UsIG1tQUNQX1NPRlRfUkVTRVQpOwpAQCAtNTU2
LDExICs1NjAsMjEgQEAgc3RhdGljIGludCBhY3BfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAKIHN0
YXRpYyBpbnQgYWNwX3N1c3BlbmQodm9pZCAqaGFuZGxlKQogeworCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOworCisJLyogcG93ZXIg
dXAgb24gc3VzcGVuZCAqLworCWlmICghYWRldi0+YWNwLmFjcF9jZWxsKQorCQlhbWRncHVfZHBt
X3NldF9wb3dlcmdhdGluZ19ieV9zbXUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfQUNQLCBmYWxz
ZSk7CiAJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgYWNwX3Jlc3VtZSh2b2lkICpoYW5kbGUp
CiB7CisJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KiloYW5kbGU7CisKKwkvKiBwb3dlciBkb3duIGFnYWluIG9uIHJlc3VtZSAqLworCWlmICghYWRl
di0+YWNwLmFjcF9jZWxsKQorCQlhbWRncHVfZHBtX3NldF9wb3dlcmdhdGluZ19ieV9zbXUoYWRl
diwgQU1EX0lQX0JMT0NLX1RZUEVfQUNQLCB0cnVlKTsKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi4x
My42Cgo=
--00000000000051973105715d0530
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--00000000000051973105715d0530--

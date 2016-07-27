From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amd/amdgpu: Add GFX and UVD PG for Carrizo
Date: Wed, 27 Jul 2016 16:20:21 -0400
Message-ID: <CADnq5_P_AMSi1kacTMfpf+OGo6KsTeaR731mG3zxnPWfwQ7+VA@mail.gmail.com>
References: <20160726153832.15191-1-tom.stdenis@amd.com>
 <20160726153832.15191-3-tom.stdenis@amd.com>
 <CADnq5_N7U8CQtLjjfxvcJghyFRAkGfGiHGM5gGB_Y51psHW8UQ@mail.gmail.com>
 <DM5PR12MB1132B4CD639F3DF4015F5A60F70E0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1361270317=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132B4CD639F3DF4015F5A60F70E0-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1361270317==
Content-Type: multipart/alternative; boundary=001a114fc84a3775140538a3bfcc

--001a114fc84a3775140538a3bfcc
Content-Type: text/plain; charset=UTF-8

Just early engineering samples are rev0.

Alex

On Tue, Jul 26, 2016 at 2:49 PM, StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org> wrote:

> I don't have rev0 hardware.  I can edit the comment but I can't test the
> switch to the logic.
>
>
> Is there even rev0 hardware in retail?
>
>
> Tom
>
>
> ------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Tuesday, July 26, 2016 14:47
> *To:* Tom St Denis
> *Cc:* amd-gfx list; StDenis, Tom
> *Subject:* Re: [PATCH 2/4] drm/amd/amdgpu: Add GFX and UVD PG for Carrizo
>
> On Tue, Jul 26, 2016 at 11:38 AM, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Enables GFX PG and UVD static PG on Carrizo class
> > asics.
> >
> > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index 9ba64989f092..289a4c4ac9e7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -1578,7 +1578,16 @@ static int vi_common_early_init(void *handle)
> >                         AMD_CG_SUPPORT_HDP_LS |
> >                         AMD_CG_SUPPORT_SDMA_MGCG |
> >                         AMD_CG_SUPPORT_SDMA_LS;
> > +               /* rev0 hardware doesn't support PG */
>
> It's probably worth correcting this comment.  A0 theoretically
> supports PG, but probably requires additional workarounds.  Something
> like "Don't enable PG on rev0 hw due to hw issues" or something like
> that.
>
> >                 adev->pg_flags = 0;
> > +               if (adev->rev_id != 0x00) {
> > +                       adev->pg_flags |= AMD_PG_SUPPORT_GFX_PG |
> > +                               AMD_PG_SUPPORT_GFX_SMG |
> > +                               AMD_PG_SUPPORT_GFX_PIPELINE;
> > +                       /* powerplay UVD PG doesn't work yet */
> > +                       if (!amdgpu_powerplay)
> > +                               adev->pg_flags |= AMD_PG_SUPPORT_UVD;
>
> It's probably worth testing UVD PG on rev0 hw as well so see if we can
> enable this on them as well.  OTOH, there isn't likely much rev0 hw in
> the wild, so it may not matter too much.
>
> Alex
>
> > +               }
> >                 adev->external_rev_id = adev->rev_id + 0x1;
> >                 break;
> >         case CHIP_STONEY:
> > --
> > 2.9.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - lists.freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx
> Archives. Using amd-gfx: To post a message to all the list members, send
> email ...
>
>
>

--001a114fc84a3775140538a3bfcc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Just early engineering samples are rev0.<br><br></div=
>Alex<br><div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Tue, Jul 26, 2016 at 2:49 PM, StDenis, Tom <span dir=3D"ltr">&lt;=
<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis-urvtwAKJhsc@public.gmane.org=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">
<div style=3D"font-size:12pt;color:#000000;background-color:#ffffff;font-fa=
mily:Calibri,Arial,Helvetica,sans-serif">
<p>I don&#39;t have rev0 hardware.=C2=A0 I can edit the comment but I can&#=
39;t test the switch to the logic.</p>
<p><br>
</p>
<p>Is there even rev0 hardware in retail?</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr style=3D"display:inline-block;width:98%">
<div dir=3D"ltr"><font style=3D"font-size:11pt" color=3D"#000000" face=3D"C=
alibri, sans-serif"><b>From:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Tuesday, July 26, 2016 14:47<br>
<b>To:</b> Tom St Denis<br>
<b>Cc:</b> amd-gfx list; StDenis, Tom<br>
<b>Subject:</b> Re: [PATCH 2/4] drm/amd/amdgpu: Add GFX and UVD PG for Carr=
izo</font>
<div>=C2=A0</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div><div><div class=3D"h5">On Tue, Jul 26, 2016 at 11:38 AM, Tom St Denis =
&lt;<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">tstdenis82@gm=
ail.com</a>&gt; wrote:<br>
&gt; Enables GFX PG and UVD static PG on Carrizo class<br>
&gt; asics.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/vi.c | 9 +++++++++<br>
&gt;=C2=A0 1 file changed, 9 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amd=
gpu/vi.c<br>
&gt; index 9ba64989f092..289a4c4ac9e7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; @@ -1578,7 +1578,16 @@ static int vi_common_early_init(void *handle)<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 AMD_CG_SUPPORT_HDP_LS |<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 AMD_CG_SUPPORT_SDMA_MGCG |<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 AMD_CG_SUPPORT_SDMA_LS;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* rev0 hardware doesn&#39;t support PG */<br>
<br>
It&#39;s probably worth correcting this comment.=C2=A0 A0 theoretically<br>
supports PG, but probably requires additional workarounds.=C2=A0 Something<=
br>
like &quot;Don&#39;t enable PG on rev0 hw due to hw issues&quot; or somethi=
ng like<br>
that.<br>
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;pg_flags =3D 0;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (adev-&gt;rev_id !=3D 0x00) {<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;pg=
_flags |=3D AMD_PG_SUPPORT_GFX_PG |<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMD_PG_SUPPORT_GFX_SMG |<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMD_PG_SUPPORT_GFX_PIPELINE;<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* powerpla=
y UVD PG doesn&#39;t work yet */<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!amdgpu=
_powerplay)<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;pg_flags |=3D AMD_PG_SUPPORT_=
UVD;<br>
<br>
It&#39;s probably worth testing UVD PG on rev0 hw as well so see if we can<=
br>
enable this on them as well.=C2=A0 OTOH, there isn&#39;t likely much rev0 h=
w in<br>
the wild, so it may not matter too much.<br>
<br>
Alex<br>
<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;external_rev_id =3D adev-&gt;rev_id + =
0x1;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CHIP_STONEY:<br>
&gt; --<br>
&gt; 2.9.2<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" tar=
get=3D"_blank">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</div></div><div style=3D"margin-bottom:20px;overflow:auto;width:100%;text-=
indent:0px">
<table style=3D"width:90%;overflow:auto;padding-top:20px;padding-bottom:20p=
x;margin-top:20px;border-top:1px dotted rgb(200,200,200);border-bottom:1px =
dotted rgb(200,200,200);background-color:rgb(255,255,255)" cellspacing=3D"0=
">
<tbody>
<tr style=3D"border-spacing:0px" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align:top;padding:0px;display:table-cel=
l">
<div></div>
<div style=3D"color:rgb(59,87,119);font-weight:normal;font-size:21px;font-f=
amily:wf_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&quo=
t;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif;line-h=
eight:21px">
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" style=3D=
"text-decoration:none" target=3D"_blank">amd-gfx Info Page - lists.freedesk=
top.org</a></div>
<div style=3D"margin:10px 0px 16px;color:rgb(102,102,102);font-weight:norma=
l;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,=
Tahoma,Arial,sans-serif;font-size:14px;line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div style=3D"display:block;color:rgb(102,102,102);font-weight:normal;font-=
family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif;font-size:14px;line-height:20px;max-height:100px;overflow:=
hidden">
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

</blockquote></div><br></div></div></div></div></div>

--001a114fc84a3775140538a3bfcc--

--===============1361270317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1361270317==--

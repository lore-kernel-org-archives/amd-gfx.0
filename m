From: "Zhang, Jack (Jian)" <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arcturus
 VF.
Date: Thu, 21 Nov 2019 15:58:48 +0000
Message-ID: <CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0@CH2PR12MB3672.namprd12.prod.outlook.com>
References: <20191121061707.25958-1-Jack.Zhang1@amd.com>
 <CADnq5_MrfFWAjC__9ccB46CYzdcLWP=DPKD70aXAm862DJLu1g@mail.gmail.com>,
 <CADnq5_OE8xi7TmgxWe2PiWVxM8pVhxAtYF=CTtT7AHOhrUhEyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0734607893=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OE8xi7TmgxWe2PiWVxM8pVhxAtYF=CTtT7AHOhrUhEyA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: zh-CN
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0734607893==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_"

--_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Alex for this review.

Both of the two patches will not influence bare-metal code path.

B. R.
Jack

 Outlook for Android<https://aka.ms/ghei36>
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, November 21, 2019 11:26:37 PM
To: Zhang, Jack (Jian) <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for arctur=
us VF.

Nevermind.  I missed the sr-iov check. Patch is:
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

On Thu, Nov 21, 2019 at 10:25 AM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
>
> Won't this impact bare metal hw that needs this?
>
> Alex
>
> On Thu, Nov 21, 2019 at 1:17 AM Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org> wrote:
> >
> > After rlcg fw 2.1, kmd driver starts to load extra fw for
> > LIST_CNTL,GPM_MEM,SRM_MEM. We needs to skip the three fw
> > because all rlcg related fw have been loaded by host driver.
> > Guest driver would load the three fw fail without this change.
> >
> > Signed-off-by: Jack Zhang <Jack.Zhang1-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index c3a42d3..eecde80 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -1470,7 +1470,10 @@ static int psp_np_fw_load(struct psp_context *ps=
p)
> >                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA5
> >                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA6
> >                     || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA7
> > -                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G))
> > +                    || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G
> > +                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTO=
RE_LIST_CNTL
> > +                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTO=
RE_LIST_GPM_MEM
> > +                   || ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTO=
RE_LIST_SRM_MEM))
> >                         /*skip ucode loading in SRIOV VF */
> >                         continue;
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CJack=
.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637099468112639673&amp;sdata=3DiC932sWNGrLeexp7wIDdr=
Z7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;reserved=3D0

--_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Thanks Alex for this review.&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Both of the two patches will not influence bare-metal code path.&nbsp;</div=
>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
B. R.&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Jack&nbsp;</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
&nbsp;<a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, November 21, 2019 11:26:37 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/amdgpu/sriov skip RLCG s/r list for=
 arcturus VF.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Nevermind.&nbsp; I missed the sr-iov check. Patch =
is:<br>
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
On Thu, Nov 21, 2019 at 10:25 AM Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;=
 wrote:<br>
&gt;<br>
&gt; Won't this impact bare metal hw that needs this?<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; On Thu, Nov 21, 2019 at 1:17 AM Jack Zhang &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;=
 wrote:<br>
&gt; &gt;<br>
&gt; &gt; After rlcg fw 2.1, kmd driver starts to load extra fw for<br>
&gt; &gt; LIST_CNTL,GPM_MEM,SRM_MEM. We needs to skip the three fw<br>
&gt; &gt; because all rlcg related fw have been loaded by host driver.<br>
&gt; &gt; Guest driver would load the three fw fail without this change.<br=
>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Jack Zhang &lt;Jack.Zhang1-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 &#43;&#43;&#43;=
&#43;-<br>
&gt; &gt;&nbsp; 1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &gt; index c3a42d3..eecde80 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &gt; @@ -1470,7 &#43;1470,10 @@ static int psp_np_fw_load(struct psp_c=
ontext *psp)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_SDMA5<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_SDMA6<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_SDMA7<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=3D A=
MDGPU_UCODE_ID_RLC_G))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_i=
d =3D=3D AMDGPU_UCODE_ID_RLC_G<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || ucode-&gt;ucode_id =3D=
=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /*skip ucode loading in SRIOV VF */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; continue;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.7.4<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D02%7C01%7CJack.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637099468112639673&amp;amp;sdat=
a=3DiC932sWNGrLeexp7wIDdrZ7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7CJack=
.Zhang1%40amd.com%7C62c30b71b3b8490862d808d76e973ae5%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637099468112639673&amp;amp;sdata=3DiC932sWNGrLeexp7w=
IDdrZ7cjVBcFv5giOTC3uHdE%2Fk%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_CH2PR12MB3672F73E41AF7AEBCAC81053BB4E0CH2PR12MB3672namp_--

--===============0734607893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0734607893==--

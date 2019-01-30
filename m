From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Remove duplicate header
Date: Wed, 30 Jan 2019 14:53:24 +0000
Message-ID: <BN6PR12MB1809C2B90CE38326E9EE2D28F7900@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181221091853.GA2319@hp-pavilion-15-notebook-pc-brajeswar>
 <CAFqt6zbRVuJ2=5nMb1S3am86tPE6117cSU32Rtyrwf8Ajk_Xrg@mail.gmail.com>,
 <CAFqtX7kxWzxF9uMoQR2wRU-D0oS3+fHaFScWdVxdJbw51q8hiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1945216269=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFqtX7kxWzxF9uMoQR2wRU-D0oS3+fHaFScWdVxdJbw51q8hiQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Brajeswar Ghosh <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Sabyasachi Gupta <sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1945216269==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809C2B90CE38326E9EE2D28F7900BN6PR12MB1809namp_"

--_000_BN6PR12MB1809C2B90CE38326E9EE2D28F7900BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

It was already fixed a while ago:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D7e07834c12b96214e95a473f7b14fc03b20e2e7a


Alex

________________________________
From: Brajeswar Ghosh <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, January 30, 2019 8:58:52 AM
To: Souptick Joarder
Cc: Zhu, Rex; Quan, Evan; Deucher, Alexander; Koenig, Christian; Zhou, Davi=
d(ChunMing); airlied-cv59FeDIM0c@public.gmane.org; Zhang, Hawking; Huang, Ray; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; linux-kernel-u79uwXL29TaqPxH82wqD4g@public.gmane.org=
g; Sabyasachi Gupta
Subject: Re: [PATCH] drm/amd/powerplay: Remove duplicate header

On Fri, Dec 21, 2018 at 6:06 PM Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>
> On Fri, Dec 21, 2018 at 2:49 PM Brajeswar Ghosh
> <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Remove hwmgr_ppt.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> Acked-by: Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

If no further comment, can we get this patch in queue for 5.1 ?

>
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/dr=
m/amd/powerplay/inc/hwmgr.h
> > index e5a60aa44b5d..07d180ce4d18 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -28,7 +28,6 @@
> >  #include "hardwaremanager.h"
> >  #include "hwmgr_ppt.h"
> >  #include "ppatomctrl.h"
> > -#include "hwmgr_ppt.h"
> >  #include "power_state.h"
> >  #include "smu_helper.h"
> >
> > --
> > 2.17.1
> >

--_000_BN6PR12MB1809C2B90CE38326E9EE2D28F7900BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">It was already fixed a while ago:=
</p>
<p style=3D"margin-top:0;margin-bottom:0"><a href=3D"https://git.kernel.org=
/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D7e07834c12b96214e=
95a473f7b14fc03b20e2e7a" class=3D"OWAAutoLink" id=3D"LPlnk237886" previewre=
moved=3D"true">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3D7e07834c12b96214e95a473f7b14fc03b20e2e7a</a></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Brajeswar Ghosh &lt;b=
rajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 30, 2019 8:58:52 AM<br>
<b>To:</b> Souptick Joarder<br>
<b>Cc:</b> Zhu, Rex; Quan, Evan; Deucher, Alexander; Koenig, Christian; Zho=
u, David(ChunMing); airlied-cv59FeDIM0c@public.gmane.org; Zhang, Hawking; Huang, Ray; amd-gfx@l=
ists.freedesktop.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; linux-kernel-fy+rA21nqHI@public.gmane.org=
rnel.org; Sabyasachi Gupta<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: Remove duplicate header</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Dec 21, 2018 at 6:06 PM Souptick Joarder &=
lt;jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Dec 21, 2018 at 2:49 PM Brajeswar Ghosh<br>
&gt; &lt;brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Remove hwmgr_ppt.h which is included more than once<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Brajeswar Ghosh &lt;brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<=
br>
&gt; &gt; ---<br>
&gt; Acked-by: Souptick Joarder &lt;jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<br>
If no further comment, can we get this patch in queue for 5.1 ?<br>
<br>
&gt;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h | 1 -<br>
&gt; &gt;&nbsp; 1 file changed, 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/=
gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; index e5a60aa44b5d..07d180ce4d18 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; @@ -28,7 &#43;28,6 @@<br>
&gt; &gt;&nbsp; #include &quot;hardwaremanager.h&quot;<br>
&gt; &gt;&nbsp; #include &quot;hwmgr_ppt.h&quot;<br>
&gt; &gt;&nbsp; #include &quot;ppatomctrl.h&quot;<br>
&gt; &gt; -#include &quot;hwmgr_ppt.h&quot;<br>
&gt; &gt;&nbsp; #include &quot;power_state.h&quot;<br>
&gt; &gt;&nbsp; #include &quot;smu_helper.h&quot;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.17.1<br>
&gt; &gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809C2B90CE38326E9EE2D28F7900BN6PR12MB1809namp_--

--===============1945216269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1945216269==--

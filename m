From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Topaz mistakenly reported as vf
Date: Tue, 19 Dec 2017 14:20:44 +0000
Message-ID: <BN6PR12MB16521EC059E5AFAE3A2F15EDF70F0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <2405754.qoBN6c2ta5@bee> <2725982.yAJCsOSm2P@localhost>
 <BY2PR1201MB0935B6DE5790F85F6CEC05FDEB0F0@BY2PR1201MB0935.namprd12.prod.outlook.com>
 <12522973.cAA0sX3idh@localhost>,
 <BY2PR1201MB0935ECB9DDC4DE571DF65433EB0F0@BY2PR1201MB0935.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1640970790=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB0935ECB9DDC4DE571DF65433EB0F0-O28G1zQ8oGkaqtME6NEo1mrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Jos=E9_Pekkarinen?= <jose.pekkarinen-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1640970790==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16521EC059E5AFAE3A2F15EDF70F0BN6PR12MB1652namp_"

--_000_BN6PR12MB16521EC059E5AFAE3A2F15EDF70F0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please make sure we only check that register on asics where it is relevant.=
  There are a bunch of VI asics.  It should probably be restricted to tonga=
 and fiji only.


Alex


________________________________
From: Yu, Xiangliang
Sent: Tuesday, December 19, 2017 2:44 AM
To: Jos=E9 Pekkarinen
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Christian
Subject: RE: Topaz mistakenly reported as vf

We can add ASIC check in vi_detect_hw_virtualization function to avoid to e=
ntry error path.
I'll submit patch later.

Thanks!

> -----Original Message-----
> From: Jos=E9 Pekkarinen [mailto:jose.pekkarinen-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org]
> Sent: Tuesday, December 19, 2017 3:27 PM
> To: Yu, Xiangliang <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian
> <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: Topaz mistakenly reported as vf
>
> On Tuesday, 19 December 2017 09:19:02 EET Yu, Xiangliang wrote:
> > Topaz doesn't support SRIOV.
> >
>
>        Hi Xiangliang,
>
>        Allow me to ask for some attention, as I'm trying to say that give=
n
> that Topaz is not having support, amdgpu_sriov_vf(adev) may return false
> and ignore the vi.c code path. Instead of it, it enters the code path and
> reaches the BUG_ON that states this is not supported.
>
>        Thanks for coming back!
>
>        Jos=E9.
>


--_000_BN6PR12MB16521EC059E5AFAE3A2F15EDF70F0BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Please make sure we only check th=
at register on asics where it is relevant.&nbsp; There are a bunch of VI as=
ics.&nbsp; It should probably be restricted to tonga and fiji only.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Yu, Xiangliang<br>
<b>Sent:</b> Tuesday, December 19, 2017 2:44 AM<br>
<b>To:</b> Jos=E9 Pekkarinen<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Chris=
tian<br>
<b>Subject:</b> RE: Topaz mistakenly reported as vf</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We can add ASIC check in vi_detect_hw_virtualizati=
on function to avoid to entry error path.<br>
I'll submit patch later.<br>
<br>
Thanks!<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Jos=E9 Pekkarinen [<a href=3D"mailto:jose.pekkarinen@canonical.c=
om">mailto:jose.pekkarinen-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org</a>]<br>
&gt; Sent: Tuesday, December 19, 2017 3:27 PM<br>
&gt; To: Yu, Xiangliang &lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br>
&gt; &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian<br>
&gt; &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: Topaz mistakenly reported as vf<br>
&gt; <br>
&gt; On Tuesday, 19 December 2017 09:19:02 EET Yu, Xiangliang wrote:<br>
&gt; &gt; Topaz doesn't support SRIOV.<br>
&gt; &gt;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hi Xiangliang,<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Allow me to ask for some att=
ention, as I'm trying to say that given<br>
&gt; that Topaz is not having support, amdgpu_sriov_vf(adev) may return fal=
se<br>
&gt; and ignore the vi.c code path. Instead of it, it enters the code path =
and<br>
&gt; reaches the BUG_ON that states this is not supported.<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for coming back!<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jos=E9.<br>
&gt; <br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16521EC059E5AFAE3A2F15EDF70F0BN6PR12MB1652namp_--

--===============1640970790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1640970790==--

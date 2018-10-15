From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC
Date: Mon, 15 Oct 2018 17:53:39 +0000
Message-ID: <BN6PR12MB18092365083B2653B547057AF7FD0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181008022344.10247-1-issor.oruam@gmail.com>
 <20181008120423.GA300@freedom>
 <CAEQFVGahx4U+52uKu20_q0iCPrdzeW8G+viS7p2LJtgF61bf6Q@mail.gmail.com>
 <20181008201706.GA351@freedom> <20181008212236.GA338@freedom>
 <CAEQFVGaErupy3y+sKA+uqQPn7x0oL1T9BKWj6y8EC12Ap2-YDw@mail.gmail.com>
 <20181015012533.GA21702@freedom>
 <CAEQFVGbB_ezGSGwPu2Ka-4rY9RjB_rJvPL8ZCEG-_rfXxOEN-A@mail.gmail.com>,
 <20181015124549.GA579@freedom>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1746836886=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181015124549.GA579@freedom>
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
To: "sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1746836886==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18092365083B2653B547057AF7FD0BN6PR12MB1809namp_"

--_000_BN6PR12MB18092365083B2653B547057AF7FD0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

There are two sets of power management code in amdgpu, the older dpm code w=
hich was ported from radeon, and the newer powerplay code which was rewritt=
en to align closer with the power management code for other OSes and the hw=
 teams.  The "powerplay" code has more features than the older dpm code, bu=
t at a fundamental level, they are pretty much the same.  Both use the same=
 SMU interfaces to support dynamic clock switching.  SI is a bit tricky bec=
ause it uses and older version of the SMU and an older power management des=
ign so it doesn't really match cleanly with the current APIs in the "powerp=
lay" code.


Alex


________________________________
From: sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, October 15, 2018 8:45 AM
To: Mauro Rossi
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry; Deucher, Alexander; Mik=
e Lothian
Subject: Re: [RFC] drm/amd/display: add SI support to AMD DC

On Mon, Oct 15, 2018 at 07:28:57AM +0200, Mauro Rossi wrote:
> dpm for SI is available, while powerplay for SI is not, but
> display/amdgpu_dm uses some powerplay calls, where get_static_clock
> functions not available and the *ERROR* DM_PPLIB is due to missing handli=
ng
> in powerplay

I though powerplay was just more power states for the dpm state machines to
play with. I recall parsing ATOMBIOS pplay tables for records of (voltages/=
clocks
frequencies).

Maybe the future is to trust the OS kernel and perform all "low speed" 3D a=
sic
functions there and keep only high speed 3D operations in the asic.

--
Sylvain

--_000_BN6PR12MB18092365083B2653B547057AF7FD0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">There are two sets of power manag=
ement code in amdgpu, the older dpm code which was ported from radeon, and =
the newer powerplay code which was rewritten to align closer with the power=
 management code for other OSes and
 the hw teams.&nbsp; The &quot;powerplay&quot; code has more features than =
the older dpm code, but at a fundamental level, they are pretty much the sa=
me.&nbsp; Both use the same SMU interfaces to support dynamic clock switchi=
ng.&nbsp; SI is a bit tricky because it uses and older version
 of the SMU and an older power management design so it doesn't really match=
 cleanly with the current APIs in the &quot;powerplay&quot; code.&nbsp;
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> sylvain.bertrand@gm=
ail.com &lt;sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, October 15, 2018 8:45 AM<br>
<b>To:</b> Mauro Rossi<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry; Deucher, Alexand=
er; Mike Lothian<br>
<b>Subject:</b> Re: [RFC] drm/amd/display: add SI support to AMD DC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Oct 15, 2018 at 07:28:57AM &#43;0200, Maur=
o Rossi wrote:<br>
&gt; dpm for SI is available, while powerplay for SI is not, but<br>
&gt; display/amdgpu_dm uses some powerplay calls, where get_static_clock<br=
>
&gt; functions not available and the *ERROR* DM_PPLIB is due to missing han=
dling<br>
&gt; in powerplay<br>
<br>
I though powerplay was just more power states for the dpm state machines to=
<br>
play with. I recall parsing ATOMBIOS pplay tables for records of (voltages/=
clocks<br>
frequencies).<br>
<br>
Maybe the future is to trust the OS kernel and perform all &quot;low speed&=
quot; 3D asic<br>
functions there and keep only high speed 3D operations in the asic.<br>
<br>
-- <br>
Sylvain<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18092365083B2653B547057AF7FD0BN6PR12MB1809namp_--

--===============1746836886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1746836886==--

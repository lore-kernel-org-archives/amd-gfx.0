From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails
Date: Fri, 12 Aug 2016 15:50:09 +0000
Message-ID: <DM5PR12MB1132E5443A7E25075E297A30F71F0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <CAPEhTTHK2uF4r4TuR4Vt4oBD9WsxyoAuwLDQ6bRSmus-BKd1eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1063752178=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPEhTTHK2uF4r4TuR4Vt4oBD9WsxyoAuwLDQ6bRSmus-BKd1eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alexander Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============1063752178==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132E5443A7E25075E297A30F71F0DM5PR12MB1132namp_"

--_000_DM5PR12MB1132E5443A7E25075E297A30F71F0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,


I wrote those changes back in March as part of a cleanup sweep.  The idea b=
eing was that if some had failed the state of the driver would be unknown s=
o it was cleaner to simply abort allocating any memory and set all of the p=
ointers to NULL.


Generally speaking if you fail to kmalloc a few bytes you've got bigger pro=
blems to worry about than your audio not working ideally.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alexandr=
e Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, August 12, 2016 11:43
To: Freedesktop - AMD-gfx
Cc: Alexander Deucher
Subject: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails

Hi,

While comparing radeon's radeon_afmt_init() to dce_vX_0_afmt_init() on the =
amdgpu's side, I saw that on the latter:
1- when kzalloc fails to allocate mem for all afmt, an ENOMEM is returned
2- all previously allocated afmt are freed

So on the amdgpu's side, it is an "all or none allocated" situation, while =
on the radeon's side, some afmt may be allocated and initialized.

Moreover, returning an ENOMEM prevents any other function calls in dce_vX_0=
_sw_init() on the amdgpu's side, while it continues on the radeon's side.

What is the expected behavior here? Should we rewind the memory allocation =
as it is done under amdgpu when we can't allocate memory for all afmt or is=
 it OK to do as it is done on radeon? Should we stop any remaining steps in=
 radeon_modeset_init() if it fails (thus, returning a ENOMEM from radeon_af=
mt_init())?

The patch is already ready if needed, I could send it later from home if th=
e amdgpu's behavior is the one that we are looking for.

Cheers,
Alexandre Demers

--_000_DM5PR12MB1132E5443A7E25075E297A30F71F0DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi,</p>
<p><br>
</p>
<p>I wrote those changes back in March as part of a cleanup sweep. &nbsp;Th=
e idea being was that if some had failed the state of the driver would be u=
nknown so it was cleaner to simply abort allocating any memory and set all =
of the pointers to NULL.</p>
<p><br>
</p>
<p>Generally speaking if you fail to kmalloc a few bytes you've got bigger =
problems to worry about than your audio not working ideally.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alexandre Demers &lt;alexandr=
e.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, August 12, 2016 11:43<br>
<b>To:</b> Freedesktop - AMD-gfx<br>
<b>Cc:</b> Alexander Deucher<br>
<b>Subject:</b> radeon VS amdgpu: _afmt_init() behavior if kzalloc fails</f=
ont>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hi,
<div><br>
</div>
<div>While comparing radeon's radeon_afmt_init() to dce_vX_0_afmt_init() on=
 the amdgpu's side, I saw that on the latter:</div>
<div>1- when kzalloc fails to allocate mem for all afmt, an ENOMEM is retur=
ned</div>
<div>2- all previously allocated afmt are freed</div>
<div><br>
</div>
<div>So on the amdgpu's side, it is an &quot;all or none allocated&quot; si=
tuation, while on the radeon's side, some afmt may be allocated and initial=
ized.</div>
<div><br>
</div>
<div>Moreover, returning an ENOMEM prevents any other function calls in&nbs=
p;<span style=3D"font-size:13.3333px; line-height:normal">dce_vX_0_</span><=
span style=3D"font-size:13.3333px; line-height:normal">sw_init() on the amd=
gpu's side, while it continues on the radeon's
 side.</span><br>
</div>
<div><span style=3D"font-size:13.3333px; line-height:normal"><br>
</span></div>
<div><span style=3D"font-size:13.3333px; line-height:normal">What is the ex=
pected behavior here? Should we rewind the memory allocation as it is done =
under amdgpu when we can't allocate memory for all afmt or is it OK to do a=
s it is done on radeon? Should we
 stop any remaining steps in radeon_modeset_init() if it fails (thus, retur=
ning a ENOMEM from radeon_afmt_init())?</span></div>
<div><span style=3D"font-size:13.3333px; line-height:normal"><br>
</span></div>
<div><span style=3D"font-size:13.3333px; line-height:normal">The patch is a=
lready ready if needed, I could send it later from home if the amdgpu's beh=
avior is the one that we are looking for.</span></div>
<div><span style=3D"font-size:13.3333px; line-height:normal"><br>
</span></div>
<div><span style=3D"font-size:13.3333px; line-height:normal">Cheers,</span>=
</div>
<div><span style=3D"font-size:13.3333px; line-height:normal">Alexandre Deme=
rs</span></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1132E5443A7E25075E297A30F71F0DM5PR12MB1132namp_--

--===============1063752178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1063752178==--

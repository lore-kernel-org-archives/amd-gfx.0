From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails
Date: Fri, 12 Aug 2016 17:41:19 +0000
Message-ID: <DM5PR12MB11328A45D10393917498880BF71F0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <CAPEhTTHK2uF4r4TuR4Vt4oBD9WsxyoAuwLDQ6bRSmus-BKd1eg@mail.gmail.com>
 <DM5PR12MB1132E5443A7E25075E297A30F71F0@DM5PR12MB1132.namprd12.prod.outlook.com>
 <CAPEhTTFw-sk4Hq_6-r2eakVMuYC07DRJc0zKa0fWm_aWF+tADQ@mail.gmail.com>
 <DM5PR12MB11326BF415D31AE5DB0B0A5EF71F0@DM5PR12MB1132.namprd12.prod.outlook.com>,
 <CAPEhTTGtJy5ApUbGedSv2XtZ5FXxWLL8X_m02DfHFdU-Lm5jXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0314919656=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPEhTTGtJy5ApUbGedSv2XtZ5FXxWLL8X_m02DfHFdU-Lm5jXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0314919656==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB11328A45D10393917498880BF71F0DM5PR12MB1132namp_"

--_000_DM5PR12MB11328A45D10393917498880BF71F0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,


That's probably fine.  Though if it's touching on ASICs that amdgpu is mean=
t to support and it's not a critical bugfix (or API update) maybe time is b=
etter spent getting support on the amdgpu side going for that hardware inst=
ead.


Cheers,

Tom


________________________________
From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, August 12, 2016 13:39
To: StDenis, Tom; Freedesktop - AMD-gfx
Cc: Alexander Deucher
Subject: Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails

Hi again,

I'm talking about modifying radeon's side to mimic amdgpu's behavior, sorry=
 for the confusion.

Cheers,
Alexandre

On Fri, 12 Aug 2016 at 12:17 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:Tom.S=
tDenis-5C7GfCeVMHo@public.gmane.org>> wrote:

Hi Alex,


I'm unsure of what patch you have specifically.  Are you suggesting to modi=
fy the radeon side to mimic the behaviour?  Or to revert the amdgpu changes=
?  I  think reverting the amdgpu side won't go over well.  It's churn and t=
he current approach is arguably better for a number of reasons namely it's =
better defined behaviour and generally speaking if during module init a kma=
lloc of 100 bytes fails something bad is happening and you want to abort in=
it anyways (so failing to load just because part of DCE fails is probably a=
 good thing).


Tom




________________________________
From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexandre.f.dem=
ers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, August 12, 2016 12:11
To: StDenis, Tom; Freedesktop - AMD-gfx
Cc: Alexander Deucher
Subject: Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails

Thanks for the quick answer Tom. I was thinking mostly as you do, but befor=
e sending the patch to the list, I wanted to be sure it was worth it.

I'll send the patch later then, unless someone says otherwise.

Cheers,
Alexandre

On Fri, 12 Aug 2016 at 11:50 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:Tom.S=
tDenis-5C7GfCeVMHo@public.gmane.org>> wrote:

Hi,


I wrote those changes back in March as part of a cleanup sweep.  The idea b=
eing was that if some had failed the state of the driver would be unknown s=
o it was cleaner to simply abort allocating any memory and set all of the p=
ointers to NULL.


Generally speaking if you fail to kmalloc a few bytes you've got bigger pro=
blems to worry about than your audio not working ideally.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Alexandre Demers <alexandre.f.demers@=
gmail.com<mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
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

--_000_DM5PR12MB11328A45D10393917498880BF71F0DM5PR12MB1132namp_
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
<p>Hi Alexandre,</p>
<p><br>
</p>
<p>That's probably fine. &nbsp;Though if it's touching on ASICs that amdgpu=
 is meant to support and it's not a critical bugfix (or API update) maybe t=
ime is better spent getting support on the amdgpu side going for that hardw=
are instead.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alexandre Demers &lt;=
alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, August 12, 2016 13:39<br>
<b>To:</b> StDenis, Tom; Freedesktop - AMD-gfx<br>
<b>Cc:</b> Alexander Deucher<br>
<b>Subject:</b> Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fail=
s</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hi again,
<div><br>
</div>
<div>I'm talking about modifying radeon's side to mimic amdgpu's behavior, =
sorry for the confusion.</div>
<div><br>
</div>
<div>Cheers,</div>
<div>Alexandre</div>
<div><br>
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Fri, 12 Aug 2016 at 12:17 StDenis, Tom &lt;<a href=3D"m=
ailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div style=3D"font-size:12pt; color:#000000; background-color:#ffffff; font=
-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi Alex,</p>
<p><br>
</p>
<p>I'm unsure of what patch you have specifically.&nbsp; Are you suggesting=
 to modify the radeon side to mimic the behaviour?&nbsp; Or to revert the a=
mdgpu changes?&nbsp; I &nbsp;think reverting the amdgpu side won't go over =
well.&nbsp; It's churn and the current approach is arguably
 better for a number of reasons namely it's better defined behaviour and ge=
nerally speaking if during module init a kmalloc of 100 bytes fails somethi=
ng bad is happening and you want to abort init anyways (so failing to load =
just because part of DCE fails is
 probably a good thing).</p>
<p><br>
</p>
<p>Tom</p>
<p><br>
</p>
<p><br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" color=3D"#000000" style=
=3D"font-size:11pt"><b>From:</b> Alexandre Demers &lt;<a href=3D"mailto:ale=
xandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a>&gt;<br>
<b>Sent:</b> Friday, August 12, 2016 12:11<br>
<b>To:</b> StDenis, Tom; Freedesktop - AMD-gfx<br>
<b>Cc:</b> Alexander Deucher<br>
<b>Subject:</b> Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fail=
s</font>
<div>&nbsp;</div>
</div>
</div>
</div>
</div>
<div dir=3D"ltr">
<div style=3D"font-size:12pt; color:#000000; background-color:#ffffff; font=
-family:Calibri,Arial,Helvetica,sans-serif">
<div style=3D"color:rgb(0,0,0)">
<div>
<div dir=3D"ltr">Thanks for the quick answer Tom.&nbsp;<span style=3D"line-=
height:1.5">I was thinking mostly as you do, but before sending the patch t=
o the list, I wanted to be sure it was worth it.</span>
<div><br>
<div>I'll send the patch later then, unless someone says otherwise.</div>
<div><br>
</div>
<div>Cheers,</div>
<div>Alexandre</div>
</div>
</div>
<br>
<div class=3D"gmail_quote">
<div dir=3D"ltr">On Fri, 12 Aug 2016 at 11:50 StDenis, Tom &lt;<a href=3D"m=
ailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt; wr=
ote:<br>
</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex; border-left:1=
px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div style=3D"font-size:12pt; color:#000000; background-color:#ffffff; font=
-family:Calibri,Arial,Helvetica,sans-serif">
<p>Hi,</p>
<p><br>
</p>
<p>I wrote those changes back in March as part of a cleanup sweep.&nbsp; Th=
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
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div dir=3D"ltr"><font face=3D"Calibri, sans-serif" color=3D"#000000" style=
=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a>&gt; on behalf of Alexandre Demers &lt;<a href=3D"mailto:alexand=
re.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t;<br>
<b>Sent:</b> Friday, August 12, 2016 11:43<br>
<b>To:</b> Freedesktop - AMD-gfx<br>
<b>Cc:</b> Alexander Deucher<br>
<b>Subject:</b> radeon VS amdgpu: _afmt_init() behavior if kzalloc fails</f=
ont>
<div>&nbsp;</div>
</div>
</div>
</div>
</div>
<div dir=3D"ltr">
<div style=3D"font-size:12pt; color:#000000; background-color:#ffffff; font=
-family:Calibri,Arial,Helvetica,sans-serif">
<div style=3D"color:rgb(0,0,0)">
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
</div>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB11328A45D10393917498880BF71F0DM5PR12MB1132namp_--

--===============0314919656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0314919656==--

From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about porting VCE1 to amdgpu
Date: Wed, 14 Jun 2017 17:30:14 +0000
Message-ID: <CAPEhTTEUBR-wXeXetU=uzA42o_2KXJfCi0s8rr_AK_7ygA3RiA@mail.gmail.com>
References: <CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww@mail.gmail.com>
 <c3b779e6-3a65-770d-5ba5-40cd293ded3e@vodafone.de>
 <BN6PR12MB165227C924CF7BC1E0D71D92F7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1066976021=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB165227C924CF7BC1E0D71D92F7C30-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1066976021==
Content-Type: multipart/alternative; boundary="001a113565c45af0860551eee834"

--001a113565c45af0860551eee834
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jun 2017 at 13:09 Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

>
>
> *From:* amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On Behalf
> Of *Christian K=C3=B6nig
> *Sent:* Wednesday, June 14, 2017 12:37 PM
> *To:* Alexandre Demers; Freedesktop - AMD-gfx
> *Subject:* Re: Question about porting VCE1 to amdgpu
>
>
>
> - Would we need a different firmware version with a different "hdr" for
> the amdgpu driver?
>
> Yes, we should probably release the latest one instead of reusing the one
> used with radeon.
>
> Actually, we should probably stick the same one as radeon for now until w=
e
> can verify the new firmware in general.  Easier to start with a known
> working case.
>

OK. Then,  is it expected to have a validation failure with the current
firmware? Is the header compatible with how the validation is done under
VCE2 and others or should I keep how it was done under radeon?


>
>
> BTW: Does VCE work on CIK? Alex, don't we run into the same issue there a=
s
> well?
>
> VCE works on CIK.  We ported VCE and UVD to CIK as part of the initial
> amdgpu bring up.
>

I've been using VCE2 port as my template for VCE1. My initial intention was
to work on UVD, but I ended up plugging in VCE in the first place. UVD is
on my todo list right next, I was expecting to working on it after fixing
the VCE part.


>
> Alex
>
>
>
> - Wouldn't it be better to continue loading the driver while having VCE
> disabled IF we fail when loading or validating the FW? Completely failing
> to load the driver for this reason seems overkill IMO, since nothing has
> been loaded in memory and no registry have been modified up to that point=
.
>
> UVD and VCE are actually needed for correct power management. When the
> blocks fail to initialize you usually sooner or later run into problems
> with power management (e.g. stuck inside a certain power level).
>
>
OK, but right now it is disabled, so the situation wouldn't be worst isn't
it?


> - Would it be a good idea to send a patch as a RFC so some of you could
> help me finish the job and maybe pinpoint where the last modifications ne=
ed
> to be done?
>
> Well you could, but to be honest without AMD releasing new firmware that
> is most likely a futile effort.
>

I'll send a patch then, and we'll navigate from there. This will allow me
to work on UVD in parallel.

Alexandre Demers


>
> Regards,
> Christian.
>
> Am 14.06.2017 um 18:22 schrieb Alexandre Demers:
>
> Hi,
>
>
>
> I've been working on porting VCE1 from radeon to amdgpu in the last few
> weeks. I'm pretty much done and I've enabled the functionality to see how
> it goes. However, I ended up with an error on the firmware validation (si=
ze
> doesn't seem to fit), thus failing completely in loading the driver. I'm
> testing on a R9 280X (Tahiti).
>
>
>
> Three questions then:
>
> - Would we need a different firmware version with a different "hdr" for
> the amdgpu driver?
>
> - Wouldn't it be better to continue loading the driver while having VCE
> disabled IF we fail when loading or validating the FW? Completely failing
> to load the driver for this reason seems overkill IMO, since nothing has
> been loaded in memory and no registry have been modified up to that point=
.
>
> - Would it be a good idea to send a patch as a RFC so some of you could
> help me finish the job and maybe pinpoint where the last modifications ne=
ed
> to be done?
>
>
>
> Thank you!
>
> Alexandre Demers
>
>
>
>
> _______________________________________________
>
> amd-gfx mailing list
>
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>

--001a113565c45af0860551eee834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, 14 Jun=
 2017 at 13:09 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@a=
md.com">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">





<div bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-2481367577652910062WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext">From:</span></b><spa=
n style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:windowtext"> amd-gfx [mailto:<a href=3D"mailto:amd-gfx-bounces=
@lists.freedesktop.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org</a>]
<b>On Behalf Of </b>Christian K=C3=B6nig<br>
<b>Sent:</b> Wednesday, June 14, 2017 12:37 PM<br>
<b>To:</b> Alexandre Demers; Freedesktop - AMD-gfx<br>
<b>Subject:</b> Re: Question about porting VCE1 to amdgpu<u></u><u></u></sp=
an></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div></div></div></div></div><div bgcolor=3D"white" lang=3D"EN-US" link=3D"=
blue" vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><d=
iv style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.=
0pt"><div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">- Would we need a different firmware version with a =
different &quot;hdr&quot; for the amdgpu driver?<u></u><u></u></p>
</blockquote>
<p class=3D"MsoNormal">Yes, we should probably release the latest one inste=
ad of reusing the one used with radeon.<br>
<br>
<span style=3D"color:#1f497d"><u></u><u></u></span></p>
</div></div></div></div><div bgcolor=3D"white" lang=3D"EN-US" link=3D"blue"=
 vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><div st=
yle=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">=
<div><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Actually, we should =
probably stick the same one as radeon for now until we can verify the new f=
irmware in general.=C2=A0 Easier to start with a known working case.</span>=
</p></div></div></div></div></blockquote><div>=C2=A0</div><div>OK. Then, =
=C2=A0is it expected to have a validation failure with the current firmware=
? Is the header compatible with how the validation is done under VCE2 and o=
thers or should I keep how it was done under radeon?</div><div><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div bgcolor=3D"white" lang=3D"EN-US" link=3D"=
blue" vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><d=
iv style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.=
0pt"><div><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u><u></u><=
/span></p></div></div></div></div><div bgcolor=3D"white" lang=3D"EN-US" lin=
k=3D"blue" vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection=
1"><div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0=
in 4.0pt"><div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><br>
BTW: Does VCE work on CIK? Alex, don&#39;t we run into the same issue there=
 as well?<br>
<br>
<span style=3D"color:#1f497d"><u></u><u></u></span></p>
</div></div></div></div><div bgcolor=3D"white" lang=3D"EN-US" link=3D"blue"=
 vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><div st=
yle=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">=
<div><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">VCE works on CIK.=C2=
=A0 We ported VCE and UVD to CIK as part of the initial amdgpu bring up.</s=
pan></p></div></div></div></div></blockquote><div>=C2=A0</div><div>I&#39;ve=
 been using VCE2 port as my template for VCE1. My initial intention was to =
work on UVD, but I ended up plugging in VCE in the first place. UVD is on m=
y todo list right next, I was expecting to working on it after fixing the V=
CE part.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div bgcolor=3D=
"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div class=3D"m_-2481=
367577652910062WordSection1"><div style=3D"border:none;border-left:solid bl=
ue 1.5pt;padding:0in 0in 0in 4.0pt"><div><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
;color:#1f497d"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Alex<u></u><u></u></span>=
</p></div></div></div></div><div bgcolor=3D"white" lang=3D"EN-US" link=3D"b=
lue" vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><di=
v style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0=
pt"><div>
<p class=3D"MsoNormal"><br>
<br>
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">- Wouldn&#39;t it be better to continue loading the =
driver while having VCE disabled IF we fail when loading or validating the =
FW? Completely failing to load the driver for this reason seems overkill IM=
O, since nothing has been loaded in memory
 and no registry have been modified up to that point.<u></u><u></u></p>
</div>
<p class=3D"MsoNormal">UVD and VCE are actually needed for correct power ma=
nagement. When the blocks fail to initialize you usually sooner or later ru=
n into problems with power management (e.g. stuck inside a certain power le=
vel).<br>
<br></p></div></div></div></div></blockquote><div>=C2=A0</div><div>OK, but =
right now it is disabled, so the situation wouldn&#39;t be worst isn&#39;t =
it?</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div bgcolor=3D"whit=
e" lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div class=3D"m_-248136757=
7652910062WordSection1"><div style=3D"border:none;border-left:solid blue 1.=
5pt;padding:0in 0in 0in 4.0pt"><div><p class=3D"MsoNormal">
<br>
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">- Would it be a good idea to send a patch as a RFC s=
o some of you could help me finish the job and maybe pinpoint where the las=
t modifications need to be done?<u></u><u></u></p>
</div>
<p class=3D"MsoNormal">Well you could, but to be honest without AMD releasi=
ng new firmware that is most likely a futile effort.<br></p></div></div></d=
iv></div></blockquote><div><br></div><div>I&#39;ll send a patch then, and w=
e&#39;ll navigate from there. This will allow me to work on UVD in parallel=
.</div><div><br></div><div>Alexandre Demers</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" v=
link=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><div styl=
e=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt"><d=
iv><p class=3D"MsoNormal">
<br>
Regards,<br>
Christian.<br>
<br>
Am 14.06.2017 um 18:22 schrieb Alexandre Demers:<u></u><u></u></p>
</div></div></div></div><div bgcolor=3D"white" lang=3D"EN-US" link=3D"blue"=
 vlink=3D"purple"><div class=3D"m_-2481367577652910062WordSection1"><div st=
yle=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<p class=3D"MsoNormal">Hi, <u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;ve been working on porting VCE1 from radeon to=
 amdgpu in the last few weeks. I&#39;m pretty much done and I&#39;ve enable=
d the functionality to see how it goes. However, I ended up with an error o=
n the firmware validation (size doesn&#39;t seem to
 fit), thus failing completely in loading the driver. I&#39;m testing on a =
R9 280X (Tahiti).<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Three questions then:<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">- Would we need a different firmware version with a =
different &quot;hdr&quot; for the amdgpu driver?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">- Wouldn&#39;t it be better to continue loading the =
driver while having VCE disabled IF we fail when loading or validating the =
FW? Completely failing to load the driver for this reason seems overkill IM=
O, since nothing has been loaded in memory
 and no registry have been modified up to that point.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">- Would it be a good idea to send a patch as a RFC s=
o some of you could help me finish the job and maybe pinpoint where the las=
t modifications need to be done?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thank you!<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Alexandre Demers<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><br>
<br>
<br>
<u></u><u></u></p>
<pre>_______________________________________________<u></u><u></u></pre>
<pre>amd-gfx mailing list<u></u><u></u></pre>
<pre><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><u></u><u></u></pre>
<pre><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" tar=
get=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><u=
></u><u></u></pre>
</blockquote>
<p><u></u>=C2=A0<u></u></p>
</div></div></div></blockquote></div></div>

--001a113565c45af0860551eee834--

--===============1066976021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1066976021==--

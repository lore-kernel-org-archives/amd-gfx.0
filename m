From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about porting VCE1 to amdgpu
Date: Tue, 27 Jun 2017 17:08:34 +0000
Message-ID: <CAPEhTTER6Y0JrTNhSoWT2bwQjoAXbXs2Ae-cdvxykiGOocX7Tg@mail.gmail.com>
References: <CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww@mail.gmail.com>
 <c3b779e6-3a65-770d-5ba5-40cd293ded3e@vodafone.de>
 <BN6PR12MB165227C924CF7BC1E0D71D92F7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAPEhTTEUBR-wXeXetU=uzA42o_2KXJfCi0s8rr_AK_7ygA3RiA@mail.gmail.com>
 <BN6PR12MB1652D5D3621EA149E668979FF7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0975373297=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652D5D3621EA149E668979FF7C30-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0975373297==
Content-Type: multipart/alternative; boundary="001a114876d2cf2d400552f41e28"

--001a114876d2cf2d400552f41e28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just a quick update: things a getting into shape slowly since my paternal
vacancy is over, but I'm still progressing. I'm debugging things as I can.
I managed to work around the missing header with the current firmware after
analyzing what it contains and where it is used.

I'm more interested than ever to have VCE and UVD ported to amdgpu, since
we now have cards from the 300 series at work (one based on GCN 1, the
other on GCN 2).

By the way, the R7 360 (based on GCN 2, Bonaire Pro) fails to load the
amdgpu driver because of an error in VCE 2 implementation.

I'll keep you up to date.

Alexandre

On Wed, 14 Jun 2017 at 14:22 Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
wrote:

>
>
> *From:* Alexandre Demers [mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> *Sent:* Wednesday, June 14, 2017 1:30 PM
> *To:* Deucher, Alexander; Christian K=C3=B6nig; Freedesktop - AMD-gfx
>
>
> *Subject:* Re: Question about porting VCE1 to amdgpu
>
> On Wed, 14 Jun 2017 at 13:09 Deucher, Alexander <Alexander.Deucher-urvtwAKJhsc@public.gmane.org=
m>
> wrote:
>
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
>
>
> OK. Then,  is it expected to have a validation failure with the current
> firmware? Is the header compatible with how the validation is done under
> VCE2 and others or should I keep how it was done under radeon?
>
> There is no header on the multi-media firmware from radeon, so you'd need
> to add one.  The header is documented in amdgpu_ucode.h,  All you'd need =
to
> do is prepend the header to the existing firmware image.
>
>
>
> Alex
>
>
>
>
>
>
> BTW: Does VCE work on CIK? Alex, don't we run into the same issue there a=
s
> well?
>
> VCE works on CIK.  We ported VCE and UVD to CIK as part of the initial
> amdgpu bring up.
>
>
>
> I've been using VCE2 port as my template for VCE1. My initial intention
> was to work on UVD, but I ended up plugging in VCE in the first place. UV=
D
> is on my todo list right next, I was expecting to working on it after
> fixing the VCE part.
>
>
>
>
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
>
> OK, but right now it is disabled, so the situation wouldn't be worst isn'=
t
> it?
>
>
>
>
>
> - Would it be a good idea to send a patch as a RFC so some of you could
> help me finish the job and maybe pinpoint where the last modifications ne=
ed
> to be done?
>
> Well you could, but to be honest without AMD releasing new firmware that
> is most likely a futile effort.
>
>
>
> I'll send a patch then, and we'll navigate from there. This will allow me
> to work on UVD in parallel.
>
>
>
> Alexandre Demers
>
>
>
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
>

--001a114876d2cf2d400552f41e28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Just a quick update: things a getting into shape slowly si=
nce my paternal vacancy is over, but I&#39;m still progressing. I&#39;m deb=
ugging things as I can. I managed to work around the missing header with th=
e current firmware after analyzing what it contains and where it is used.<d=
iv><br></div><div>I&#39;m more interested than ever to have VCE and UVD por=
ted to amdgpu, since we now have cards from the 300 series at work (one bas=
ed on GCN 1, the other on GCN 2).</div><div><br></div><div>By the way, the =
R7 360 (based on GCN 2, Bonaire Pro) fails to load the amdgpu driver becaus=
e of an error in VCE 2 implementation.</div><div><br></div><div>I&#39;ll ke=
ep you up to date.</div><div><br></div><div>Alexandre</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr">On Wed, 14 Jun 2017 at 14:22 Deucher,=
 Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deuch=
er-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"m_4865710171043609442WordSection1">
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
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Alexandr=
e Demers [mailto:<a href=3D"mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"=
_blank">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
<b>Sent:</b> Wednesday, June 14, 2017 1:30 PM<br>
<b>To:</b> Deucher, Alexander; Christian K=C3=B6nig; Freedesktop - AMD-gfx<=
/span></p></div></div></div></div></div><div lang=3D"EN-US" link=3D"blue" v=
link=3D"purple"><div class=3D"m_4865710171043609442WordSection1"><div style=
=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt"><di=
v><div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0i=
n 0in 0in"><p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-fami=
ly:&quot;Tahoma&quot;,&quot;sans-serif&quot;"><br>
<b>Subject:</b> Re: Question about porting VCE1 to amdgpu<u></u><u></u></sp=
an></p></div></div></div></div></div><div lang=3D"EN-US" link=3D"blue" vlin=
k=3D"purple"><div class=3D"m_4865710171043609442WordSection1"><div style=3D=
"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt"><div><=
div>
<div>
<p class=3D"MsoNormal">On Wed, 14 Jun 2017 at 13:09 Deucher, Alexander &lt;=
<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Alexander.De=
ucher-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0</span><u></u><u></=
u></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"=
_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
<b>On Behalf Of </b>Christian K=C3=B6nig<br>
<b>Sent:</b> Wednesday, June 14, 2017 12:37 PM<br>
<b>To:</b> Alexandre Demers; Freedesktop - AMD-gfx<br>
<b>Subject:</b> Re: Question about porting VCE1 to amdgpu</span><u></u><u><=
/u></p>
</div>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
</div>
</div>
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">- Would we need a different firmware version with a =
different &quot;hdr&quot; for the amdgpu driver?<u></u><u></u></p>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Yes, we should probab=
ly release the latest one instead of reusing the one used with radeon.<u></=
u><u></u></p>
</div>
</div>
</div>
</div>
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Actually, we should proba=
bly stick the same one as radeon for now until we can verify the new firmwa=
re
 in general.=C2=A0 Easier to start with a known working case.</span><u></u>=
<u></u></p>
</div>
</div>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
</div></div></div></div></div><div lang=3D"EN-US" link=3D"blue" vlink=3D"pu=
rple"><div class=3D"m_4865710171043609442WordSection1"><div style=3D"border=
:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt"><div><div><di=
v>
<p class=3D"MsoNormal">OK. Then, =C2=A0is it expected to have a validation =
failure with the current firmware? Is the header compatible with how the va=
lidation is done under VCE2 and others or should I keep how it was done und=
er radeon?<u></u><u></u></p>
</div></div></div></div></div></div><div lang=3D"EN-US" link=3D"blue" vlink=
=3D"purple"><div class=3D"m_4865710171043609442WordSection1"><div style=3D"=
border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt"><div><d=
iv><div><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:=
&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">There is no heade=
r on the multi-media firmware from radeon, so you&#39;d need to add one.=C2=
=A0 The header is documented in amdgpu_ucode.h,=C2=A0 All you&#39;d need to=
 do is
 prepend the header to the existing firmware image.<u></u><u></u></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Alex<u></u><u></u></span>=
</p>
</div></div></div></div></div></div><div lang=3D"EN-US" link=3D"blue" vlink=
=3D"purple"><div class=3D"m_4865710171043609442WordSection1"><div style=3D"=
border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt"><div><d=
iv>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0</span><u></u><u></=
u></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
BTW: Does VCE work on CIK? Alex, don&#39;t we run into the same issue there=
 as well?<u></u><u></u></p>
</div>
</div>
</div>
</div>
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">VCE works on CIK.=C2=A0 W=
e ported VCE and UVD to CIK as part of the initial amdgpu bring up.</span><=
u></u><u></u></p>
</div>
</div>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;ve been using VCE2 port as my template for VCE=
1. My initial intention was to work on UVD, but I ended up plugging in VCE =
in the first place. UVD is on my todo list right next, I was expecting to w=
orking on it after fixing the VCE part.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">=C2=A0</span><u></u><u></=
u></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Alex</span><u></u><u></u>=
</p>
</div>
</div>
</div>
</div>
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><u></u>=C2=A0<u></u><=
/p>
<div>
<p class=3D"MsoNormal">- Wouldn&#39;t it be better to continue loading the =
driver while having VCE disabled IF we fail when loading or validating the =
FW? Completely failing to load the driver for this reason
 seems overkill IMO, since nothing has been loaded in memory and no registr=
y have been modified up to that point.<u></u><u></u></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">UVD and VCE are actua=
lly needed for correct power management. When the blocks fail to initialize=
 you usually sooner or later run into problems with power management (e.g. =
stuck inside
 a certain power level).<u></u><u></u></p>
</div>
</div>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">OK, but right now it is disabled, so the situation w=
ouldn&#39;t be worst isn&#39;t it?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">- Would it be a good idea to send a patch as a RFC s=
o some of you could help me finish the job and maybe pinpoint where the las=
t modifications need to be done?<u></u><u></u></p>
</div>
<p class=3D"MsoNormal">Well you could, but to be honest without AMD releasi=
ng new firmware that is most likely a futile effort.<u></u><u></u></p>
</div>
</div>
</div>
</div>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;ll send a patch then, and we&#39;ll navigate f=
rom there. This will allow me to work on UVD in parallel.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Alexandre Demers<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<p class=3D"MsoNormal"><br>
Regards,<br>
Christian.<br>
<br>
Am 14.06.2017 um 18:22 schrieb Alexandre Demers:<u></u><u></u></p>
</div>
</div>
</div>
</div>
<div>
<div>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<p class=3D"MsoNormal">Hi,
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I&#39;ve been working on porting VCE1 from radeon to=
 amdgpu in the last few weeks. I&#39;m pretty much done and I&#39;ve enable=
d the functionality to see how it goes. However, I ended up with
 an error on the firmware validation (size doesn&#39;t seem to fit), thus f=
ailing completely in loading the driver. I&#39;m testing on a R9 280X (Tahi=
ti).<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
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
FW? Completely failing to load the driver for this reason
 seems overkill IMO, since nothing has been loaded in memory and no registr=
y have been modified up to that point.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">- Would it be a good idea to send a patch as a RFC s=
o some of you could help me finish the job and maybe pinpoint where the las=
t modifications need to be done?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thank you!<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Alexandre Demers<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
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
<p>=C2=A0<u></u><u></u></p>
</div>
</div>
</div>
</blockquote>
</div></div></div></div></div></blockquote></div>

--001a114876d2cf2d400552f41e28--

--===============0975373297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0975373297==--

From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Limit gpu max clock for ryzen 2400g
Date: Tue, 26 Mar 2019 16:47:15 +0200
Message-ID: <CAGyaPbAzavY+yj3nx0dzpJ=4DrLJ7BXSBfiDj9xPLCWu445T2Q@mail.gmail.com>
References: <CAGyaPbDqJMTmHyat25b63yu_zEygJwKHrrnrWyH=1vPuxiLwHw@mail.gmail.com>
 <BN6PR12MB161863EACE35A0F3BE920AC2855F0@BN6PR12MB1618.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0952898911=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB161863EACE35A0F3BE920AC2855F0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0952898911==
Content-Type: multipart/alternative; boundary="00000000000048d88f0585006657"

--00000000000048d88f0585006657
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Thanx for helping, but I have tried those methods and they didn't work on
Ryzen 2400G.

--
Lauri

On Tue, Mar 26, 2019 at 2:57 PM Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Lauri,
>
>
>
> There=E2=80=99s a more efficient method using the Power Profiles (and opt=
ionally,
> the ROCM-SMI tool, found at https://github.com/RadeonOpenCompute/ROC-smi)=
,
> or the pp_sclk mask, depending on what exactly you want. I=E2=80=99ll lis=
t out the
> methods here and the rocm-smi and non-SMI commands to do it. I=E2=80=99ll=
 assume
> that this GPU is card0 (it may be card1, card2, etc, depending on what GP=
Us
> are installed on your system; =E2=80=9Crocm-smi -i=E2=80=9D or =E2=80=9Cc=
at
> /sys/class/drm/card?/device/device will give you the GPU IDs of all of th=
e
> cards, then you can figure out which one you want to use)
>
>
>
>    1. Mask the SCLKs . pp_dpm_sclk allows you to set a mask of what
>    levels to use.
>       1. First, read the values (=E2=80=9Crocm-smi --showclkfrq=E2=80=9D =
, or =E2=80=9Ccat
>       /sys/class/drm/card0/device/pp_dpm_sclk=E2=80=9D) and see the suppo=
rted DPM levels
>       for your card.
>       2. Mask off the levels that you don=E2=80=99t want. E.g. If you onl=
y want
>       to use levels 0-6 (and thus skip level 7), you can do either =E2=80=
=98rocm-smi
>       --setsclk 0 1 2 3 4 5 6=E2=80=99 or =E2=80=98echo manual >
>       /sys/class/drm/card0/device/power_dpm_force_performance_level && ec=
ho =E2=80=9C0 1
>       2 3 4 5 6=E2=80=9D > /sys/class/drm/card0/device/pp_dpm_sclk=E2=80=
=99 . This will set DPM
>       to only use levels 0-6 and skip level 7. You can do this for any
>       combination of levels or a single level (=E2=80=9C0 2 5=E2=80=9D, =
=E2=80=9C1 2 7=E2=80=9D, =E2=80=9C5=E2=80=9D, etc). That
>       will tell it to only use the specified DPM levels and will persist =
until
>       reboot, or until the power_dpm_force_performance is set back to =E2=
=80=98auto=E2=80=99 .
>    2. Set the specific DPM level values manually:
>       1. First, you=E2=80=99ll need to enable the Power Profile Overdrive
>       functionality. The easiest way is to add =E2=80=9Camdgpu.ppfeaturem=
ask=3D0xffffffff=E2=80=9D
>       to your linux command line parameters (by editing /boot/grub/grub.c=
fg
>       manually, editing /etc/default/grub and doing an update-grub, or ma=
nually
>       entering the kernel parameter in the GRUB menu before booting).
>       2. Once that=E2=80=99s enabled, you should see the following file:
>       /sys/class/drm/card0/device/pp_od_clk_voltage.
>       3. Check the current DPM level information with =E2=80=9Crocm-smi -=
S=E2=80=9D or
>       =E2=80=9Ccat /sys/class/drm/card0/device/pp_od_clk_voltage file=E2=
=80=9D . Now that we have
>       that, you can see the supported SCLK and voltages for each level.
>       4. You can use the rocm-smi tool to manually change the levels
>       through =E2=80=9Crocm-smi --setslevel # MHZ VLT=E2=80=9D, where:
>
>                                                                i.       #
> is the level (level 7 is probably the one you want, but you can do it for
> all of them)
>
>                                                              ii.      MHZ
> is the speed in MHz
>
>                                                            iii.      VLT
> is the voltage in mV.
>
>    1. Honestly, you can probably just copy the highest level that you=E2=
=80=99re
>       comfortable with and set that for all of the levels that exceed the=
 values
>       that you desire. So if you want to keep it to whatever level 6 is, =
just set
>       level 7 to have the same values as level 6 (that way you don=E2=80=
=99t have to muck
>       with voltages and such). Or if 5 is the highest that you want, set =
level 6
>       and level 7 to match level 5
>
>
>
> Hopefully that helps. It also means that you don=E2=80=99t have to consta=
ntly try
> to build your own kernel with a change to cap the SCLK cherry-picked on
> tpo. Please let me know if you have any questions at all!
>
>
>
> Kent
>
>
>
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> *On Behalf Of *La=
uri
> Ehrenpreis
> *Sent:* Friday, March 22, 2019 6:18 AM
> *To:* amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Limit gpu max clock for ryzen 2400g
>
>
>
> Hi!
>
>
>
> Is there a way how to limit gpu max clock rate? Currently I can either
> leave the clock to automatic mode or force it to specific level
> via /sys/class/drm/card0/device/pp_dpm_sclk. But ideally I would like the
> clock to be automatically regulated but specify a different upper limit f=
or
> power saving reasons.
>
>
>
> --
>
> Lauri
>

--00000000000048d88f0585006657
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi!=C2=A0<div><br></div><div>Thanx for helping, but I have=
 tried those methods and they didn&#39;t work on Ryzen 2400G.</div><div><br=
></div><div>--</div><div>Lauri</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 26, 2019 at 2:57 PM Russell=
, Kent &lt;<a href=3D"mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Russell-5C7GfCeVMHo@public.gmane.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_-2496531401980789461WordSection1">
<p class=3D"MsoNormal">Hi Lauri,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">There=E2=80=99s a more efficient method using the Po=
wer Profiles (and optionally, the ROCM-SMI tool, found at
<a href=3D"https://github.com/RadeonOpenCompute/ROC-smi" target=3D"_blank">=
https://github.com/RadeonOpenCompute/ROC-smi</a>), or the pp_sclk mask, dep=
ending on what exactly you want. I=E2=80=99ll list out the methods here and=
 the rocm-smi and non-SMI commands to do it. I=E2=80=99ll assume that
 this GPU is card0 (it may be card1, card2, etc, depending on what GPUs are=
 installed on your system; =E2=80=9Crocm-smi -i=E2=80=9D or =E2=80=9Ccat /s=
ys/class/drm/card?/device/device will give you the GPU IDs of all of the ca=
rds, then you can figure out which one you want to use)<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-=
left:0in">Mask the SCLKs . pp_dpm_sclk allows you to set a mask of what lev=
els to use.
<u></u><u></u></li><ol style=3D"margin-top:0in" start=3D"1" type=3D"a">
<li class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-=
left:0in">First, read the values (=E2=80=9Crocm-smi --showclkfrq=E2=80=9D ,=
 or =E2=80=9Ccat /sys/class/drm/card0/device/pp_dpm_sclk=E2=80=9D) and see =
the supported DPM levels for your card.
<u></u><u></u></li><li class=3D"gmail-m_-2496531401980789461MsoListParagrap=
h" style=3D"margin-left:0in">Mask off the levels that you don=E2=80=99t wan=
t. E.g. If you only want to use levels 0-6 (and thus skip level 7), you can=
 do either =E2=80=98rocm-smi --setsclk 0 1 2 3 4 5 6=E2=80=99 or =E2=80=98e=
cho manual &gt; /sys/class/drm/card0/device/power_dpm_force_performance_lev=
el
 &amp;&amp; echo =E2=80=9C0 1 2 3 4 5 6=E2=80=9D &gt; /sys/class/drm/card0/=
device/pp_dpm_sclk=E2=80=99 . This will set DPM to only use levels 0-6 and =
skip level 7. You can do this for any combination of levels or a single lev=
el (=E2=80=9C0 2 5=E2=80=9D, =E2=80=9C1 2 7=E2=80=9D, =E2=80=9C5=E2=80=9D, =
etc). That will tell it to only use the
 specified DPM levels and will persist until reboot, or until the power_dpm=
_force_performance is set back to =E2=80=98auto=E2=80=99 .<u></u><u></u></l=
i></ol>
<li class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-=
left:0in">Set the specific DPM level values manually:<u></u><u></u></li><ol=
 style=3D"margin-top:0in" start=3D"1" type=3D"a">
<li class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-=
left:0in">First, you=E2=80=99ll need to enable the Power Profile Overdrive =
functionality. The easiest way is to add =E2=80=9Camdgpu.ppfeaturemask=3D0x=
ffffffff=E2=80=9D to your linux command line parameters (by editing
 /boot/grub/grub.cfg manually, editing /etc/default/grub and doing an updat=
e-grub, or manually entering the kernel parameter in the GRUB menu before b=
ooting).<u></u><u></u></li><li class=3D"gmail-m_-2496531401980789461MsoList=
Paragraph" style=3D"margin-left:0in">Once that=E2=80=99s enabled, you shoul=
d see the following file: /sys/class/drm/card0/device/pp_od_clk_voltage.<u>=
</u><u></u></li><li class=3D"gmail-m_-2496531401980789461MsoListParagraph" =
style=3D"margin-left:0in">Check the current DPM level information with =E2=
=80=9Crocm-smi -S=E2=80=9D or =E2=80=9Ccat /sys/class/drm/card0/device/pp_o=
d_clk_voltage file=E2=80=9D . Now that we have that, you can see the suppor=
ted SCLK and voltages
 for each level. <u></u><u></u></li><li class=3D"gmail-m_-24965314019807894=
61MsoListParagraph" style=3D"margin-left:0in">You can use the rocm-smi tool=
 to manually change the levels through =E2=80=9Crocm-smi --setslevel # MHZ =
VLT=E2=80=9D, where:<u></u><u></u></li></ol>
</ol>
<p class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-l=
eft:1.5in">
<u></u><span><span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>i.<span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 </span></span><u></u>=C2=A0# is the level (level 7 is pr=
obably the one you want, but you can do it for all of them)<u></u><u></u></=
p>
<p class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-l=
eft:1.5in">
<u></u><span><span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>ii.<span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 </span></span><u></u>MHZ is the speed in MHz<u></u><u></=
u></p>
<p class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-l=
eft:1.5in">
<u></u><span><span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
</span>iii.<span style=3D"font:7pt &quot;Times New Roman&quot;">=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 </span></span><u></u>VLT is the voltage in mV.
<u></u><u></u></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<ol style=3D"margin-top:0in" start=3D"5" type=3D"a">
<li class=3D"gmail-m_-2496531401980789461MsoListParagraph" style=3D"margin-=
left:0in">Honestly, you can probably just copy the highest level that you=
=E2=80=99re comfortable with and set that for all of the levels that exceed=
 the values that you desire. So if you want to keep
 it to whatever level 6 is, just set level 7 to have the same values as lev=
el 6 (that way you don=E2=80=99t have to muck with voltages and such). Or i=
f 5 is the highest that you want, set level 6 and level 7 to match level 5<=
u></u><u></u></li></ol>
</ol>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Hopefully that helps. It also means that you don=E2=
=80=99t have to constantly try to build your own kernel with a change to ca=
p the SCLK cherry-picked on tpo. Please let me know if you have any questio=
ns at all!<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Kent<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a>&gt;
<b>On Behalf Of </b>Lauri Ehrenpreis<br>
<b>Sent:</b> Friday, March 22, 2019 6:18 AM<br>
<b>To:</b> amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
" target=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Subject:</b> Limit gpu max clock for ryzen 2400g<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Hi!<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Is there a way how to limit gpu max clock rate? Curr=
ently I can either leave the clock to automatic mode or force it to specifi=
c level via=C2=A0/sys/class/drm/card0/device/pp_dpm_sclk. But ideally I wou=
ld like the clock to be automatically regulated
 but specify a different upper limit for power saving reasons.<u></u><u></u=
></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">--<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Lauri<u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>

</blockquote></div>

--00000000000048d88f0585006657--

--===============0952898911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0952898911==--

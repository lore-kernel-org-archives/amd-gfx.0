From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: MCLK defaults high on second card
Date: Thu, 1 Feb 2018 18:54:40 +0000
Message-ID: <BN6PR12MB16525ABF6BD68B2D902C7514F7FA0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <dd618807-ecbf-cb2f-dada-e94aa1adf915@amd.com>
 <BN6PR12MB16520C31C35E33A8A790F84DF7FA0@BN6PR12MB1652.namprd12.prod.outlook.com>,
 <01e38632-df19-5110-6af2-09f915fba390@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0414986981=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <01e38632-df19-5110-6af2-09f915fba390-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============0414986981==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16525ABF6BD68B2D902C7514F7FA0BN6PR12MB1652namp_"

--_000_BN6PR12MB16525ABF6BD68B2D902C7514F7FA0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Does it also work properly with dc disabled?  I suspect a bug somewhere in =
the display info that dc generated when no displays are attached.  See smu7=
_program_display_gap().

Alex

________________________________
From: StDenis, Tom
Sent: Thursday, February 1, 2018 1:43 PM
To: Deucher, Alexander; amd-gfx mailing list
Cc: Zhu, Rex
Subject: Re: MCLK defaults high on second card

On 01/02/18 01:36 PM, Deucher, Alexander wrote:
> Are there any displays attached to the secondary card with the mclks
> stuck high?  If not, does attaching a display help?

Stealing the display from my primary (CZ in this case) does help, and
then putting it back the MCLK remains low.

Tom

>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom
> St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, February 1, 2018 1:14:43 PM
> *To:* amd-gfx mailing list
> *Cc:* Zhu, Rex
> *Subject:* MCLK defaults high on second card
> Hi,
>
> I have a setup with a CZ + Polaris10 and on the Polaris10 the SCLK idles
> low and the MCLK stays in the 2nd state (1750MHz) but on my Workstation
> which has a single 560 in it the card idles at 300MHz (with the stock
> FC27 kernel).
>
> Is there an issue with non-primary cards idling properly?
>
> Doing
>
> echo 0 > /sys/devices/pci0000:00/0000:00:03.1/0000:21:00.0/pp_dpm_mclk
>
> Doesn't result in low clock rates either.
>
> Tom
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_BN6PR12MB16525ABF6BD68B2D902C7514F7FA0BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Does it also work properly with d=
c disabled?&nbsp; I suspect a bug somewhere in the display info that dc gen=
erated when no displays are attached.&nbsp; See
<span>smu7_program_display_gap</span>().<br>
</p>
</div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, H=
elvetica, sans-serif, &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<br>
</div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); font-family: Calibri, H=
elvetica, sans-serif, &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,=
 &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &=
quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
Alex<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1" customtabindex=
=3D"-1" disabled=3D"true">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> StDenis, Tom<br>
<b>Sent:</b> Thursday, February 1, 2018 1:43 PM<br>
<b>To:</b> Deucher, Alexander; amd-gfx mailing list<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> Re: MCLK defaults high on second card</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 01/02/18 01:36 PM, Deucher, Alexander wrote:<br=
>
&gt; Are there any displays attached to the secondary card with the mclks <=
br>
&gt; stuck high?&nbsp; If not, does attaching a display help?<br>
<br>
Stealing the display from my primary (CZ in this case) does help, and <br>
then putting it back the MCLK remains low.<br>
<br>
Tom<br>
<br>
&gt; <br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behal=
f of Tom <br>
&gt; St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; *Sent:* Thursday, February 1, 2018 1:14:43 PM<br>
&gt; *To:* amd-gfx mailing list<br>
&gt; *Cc:* Zhu, Rex<br>
&gt; *Subject:* MCLK defaults high on second card<br>
&gt; Hi,<br>
&gt; <br>
&gt; I have a setup with a CZ &#43; Polaris10 and on the Polaris10 the SCLK=
 idles<br>
&gt; low and the MCLK stays in the 2nd state (1750MHz) but on my Workstatio=
n<br>
&gt; which has a single 560 in it the card idles at 300MHz (with the stock<=
br>
&gt; FC27 kernel).<br>
&gt; <br>
&gt; Is there an issue with non-primary cards idling properly?<br>
&gt; <br>
&gt; Doing<br>
&gt; <br>
&gt; echo 0 &gt; /sys/devices/pci0000:00/0000:00:03.1/0000:21:00.0/pp_dpm_m=
clk<br>
&gt; <br>
&gt; Doesn't result in low clock rates either.<br>
&gt; <br>
&gt; Tom<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk175129" previewremoved=3D"true" tabindex=3D"-1" disabled=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16525ABF6BD68B2D902C7514F7FA0BN6PR12MB1652namp_--

--===============0414986981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0414986981==--

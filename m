From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: MCLK defaults high on second card
Date: Thu, 1 Feb 2018 18:36:40 +0000
Message-ID: <BN6PR12MB16520C31C35E33A8A790F84DF7FA0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <dd618807-ecbf-cb2f-dada-e94aa1adf915@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1215800986=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dd618807-ecbf-cb2f-dada-e94aa1adf915-5C7GfCeVMHo@public.gmane.org>
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

--===============1215800986==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16520C31C35E33A8A790F84DF7FA0BN6PR12MB1652namp_"

--_000_BN6PR12MB16520C31C35E33A8A790F84DF7FA0BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Are there any displays attached to the secondary card with the mclks stuck =
high?  If not, does attaching a display help?


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom St D=
enis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, February 1, 2018 1:14:43 PM
To: amd-gfx mailing list
Cc: Zhu, Rex
Subject: MCLK defaults high on second card

Hi,

I have a setup with a CZ + Polaris10 and on the Polaris10 the SCLK idles
low and the MCLK stays in the 2nd state (1750MHz) but on my Workstation
which has a single 560 in it the card idles at 300MHz (with the stock
FC27 kernel).

Is there an issue with non-primary cards idling properly?

Doing

echo 0 > /sys/devices/pci0000:00/0000:00:03.1/0000:21:00.0/pp_dpm_mclk

Doesn't result in low clock rates either.

Tom
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16520C31C35E33A8A790F84DF7FA0BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Are there any displays attached t=
o the secondary card with the mclks stuck high?&nbsp; If not, does attachin=
g a display help?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tom St Denis &lt;tom.stdenis@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, February 1, 2018 1:14:43 PM<br>
<b>To:</b> amd-gfx mailing list<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> MCLK defaults high on second card</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
I have a setup with a CZ &#43; Polaris10 and on the Polaris10 the SCLK idle=
s <br>
low and the MCLK stays in the 2nd state (1750MHz) but on my Workstation <br=
>
which has a single 560 in it the card idles at 300MHz (with the stock <br>
FC27 kernel).<br>
<br>
Is there an issue with non-primary cards idling properly?<br>
<br>
Doing<br>
<br>
echo 0 &gt; /sys/devices/pci0000:00/0000:00:03.1/0000:21:00.0/pp_dpm_mclk<b=
r>
<br>
Doesn't result in low clock rates either.<br>
<br>
Tom<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB16520C31C35E33A8A790F84DF7FA0BN6PR12MB1652namp_--

--===============1215800986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1215800986==--

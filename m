From: Jarkko Korpi <jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: rx480 error messages with 4.8rc2
Date: Sun, 21 Aug 2016 12:59:18 +0000
Message-ID: <AM3PR08MB02772FEC299F8D2ED4D9086CE9E90@AM3PR08MB0277.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2140486428=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2140486428==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM3PR08MB02772FEC299F8D2ED4D9086CE9E90AM3PR08MB0277eurp_"

--_000_AM3PR08MB02772FEC299F8D2ED4D9086CE9E90AM3PR08MB0277eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I quess these are rather harmless.


[    1.533109] amdgpu 0000:01:00.0: Invalid PCI ROM header signature: expec=
ting 0xaa55, got 0xffff
  1.532641] CRAT table not found

  1.534583] Can't find requested voltage id in vdd_dep_on_sclk table!


But even they all would be harmless I think it's worth to fix even silence =
the messages since it causes false alarms and people try to search these ca=
uses until they are fixed.



--_000_AM3PR08MB02772FEC299F8D2ED4D9086CE9E90AM3PR08MB0277eurp_
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
<p>I quess these are rather harmless.</p>
<p><br>
</p>
<p></p>
<div>[&nbsp;&nbsp;&nbsp; 1.533109] amdgpu 0000:01:00.0: Invalid PCI ROM hea=
der signature: expecting 0xaa55, got 0xffff<br>
</div>
<div>&nbsp; 1.532641] CRAT table not found<br>
</div>
<p></p>
<p></p>
<div>&nbsp; 1.534583] Can't find requested voltage id in vdd_dep_on_sclk ta=
ble!<br>
</div>
<p></p>
<p><br>
</p>
<p>But even they all would be harmless I think it's worth to fix even silen=
ce the messages since it causes false alarms and people try to search these=
 causes until they are fixed.</p>
<p><br>
</p>
<p><br>
</p>
</div>
</body>
</html>

--_000_AM3PR08MB02772FEC299F8D2ED4D9086CE9E90AM3PR08MB0277eurp_--

--===============2140486428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2140486428==--

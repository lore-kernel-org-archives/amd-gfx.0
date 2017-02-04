From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Initial Public Release of AMDGPU debugger
Date: Sat, 4 Feb 2017 18:44:12 +0000
Message-ID: <CY4PR12MB1768FC3929359AE16372D90FF74E0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165192470=="
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0165192470==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768FC3929359AE16372D90FF74E0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768FC3929359AE16372D90FF74E0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,


We're pleased to announce the initial public release of the AMDGPU User Mod=
e Register debugger (umr).  This tool allows privileged users to read and w=
rite GPU registers in order to diagnose, debug, and aid in development of A=
MDGPU features.  The tool supports a variety of other commands for actions =
such as decoding ring contents, analyzing wavefronts, viewing machine statu=
s, and more.  It supports SI through VI devices and requires a very recent =
kernel (what will be 4.10).


The tool is released publicly under a MIT open source license and is hosted=
 at


https://cgit.freedesktop.org/amd/umr/


We welcome all developers to try it out and submit feedback, suggestions, b=
ug reports, and patches to this mailing list.


The project started internally as a debug aid last year and was the driving=
 force behind the debugfs changes over the last year.   The tool has mature=
d enough that we feel the community will be best served by having access to=
 it and after having been granted permission to release it I've squashed mo=
st of our internal history down to a few commits which are now available to=
 the public.


Development of the tool has been alongside the AMD staging 4.9 tree which h=
as commits slotted for 4.10 and 4.11.  Most features should work with a 4.9=
 vanilla kernel but users are recommended to really use 4.10 or newer kerne=
ls.   Within reason we will try to accommodate older kernels but it is not =
our primary focus.


Future work will be done through patches submitted to the list to foster co=
mmunity involvement.


Cheers,

Tom St Denis

--_000_CY4PR12MB1768FC3929359AE16372D90FF74E0CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hello all,</p>
<p><br>
</p>
<p>We're pleased to announce the initial public release of the AMDGPU User =
Mode Register debugger (umr). &nbsp;This tool allows privileged users to re=
ad and write GPU registers in order to diagnose, debug, and aid in developm=
ent of AMDGPU features. &nbsp;The tool supports
 a variety of other commands for actions such as decoding ring contents, an=
alyzing wavefronts, viewing machine status, and more. &nbsp;It supports SI =
through VI devices and requires a very recent kernel (what will be 4.10).</=
p>
<p><br>
</p>
<p>The tool is released publicly under a MIT open source license and is hos=
ted at&nbsp;</p>
<p><br>
</p>
<p><a href=3D"https://cgit.freedesktop.org/amd/umr/" class=3D"OWAAutoLink" =
id=3D"LPlnk777633" previewremoved=3D"true">https://cgit.freedesktop.org/amd=
/umr/</a><br>
</p>
<p><br>
</p>
<p>We welcome all developers to try it out and submit feedback, suggestions=
, bug reports, and patches to this mailing list.</p>
<p><br>
</p>
<p>The project started internally as a debug aid last year and was the driv=
ing force behind the debugfs changes over the last year. &nbsp; The tool ha=
s matured enough that we feel the community will be best served by having a=
ccess to it and after having been granted
 permission to release it I've squashed most of our internal history down t=
o a few commits which are now available to the public.</p>
<p><br>
</p>
<p>Development of the tool has been alongside the AMD staging 4.9 tree whic=
h has commits slotted for 4.10 and 4.11. &nbsp;Most features should work wi=
th a 4.9 vanilla kernel but users are recommended to really use 4.10 or new=
er kernels. &nbsp; Within reason we will try
 to accommodate older kernels but it is not our primary focus.</p>
<p><br>
</p>
<p>Future work will be done through patches submitted to the list to foster=
 community involvement.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom St Denis</p>
</div>
</body>
</html>

--_000_CY4PR12MB1768FC3929359AE16372D90FF74E0CY4PR12MB1768namp_--

--===============0165192470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0165192470==--

From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: dc: Remove unused display_mode_vba.c
Date: Mon, 22 Jan 2018 21:29:35 +0000
Message-ID: <BN6PR12MB1652474AC2D090E0D3D9C931F7EC0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180118210353.18842-2-harry.wentland@amd.com>,
 <20180122212733.18899-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1362850066=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180122212733.18899-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, "Laktyushkin, Dmytro" <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>

--===============1362850066==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652474AC2D090E0D3D9C931F7EC0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652474AC2D090E0D3D9C931F7EC0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, January 22, 2018 4:27 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Grodzovsky, Andrey; Cheng, Tony; Laktyus=
hkin, Dmytro; Deucher, Alexander
Cc: Wentland, Harry
Subject: [PATCH v2] drm/amd/display: dc: Remove unused display_mode_vba.c

We're currently not using this.

v2: More files and includes to remove.

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |    6 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.h  |    3 -
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  | 6085 ----------------=
----
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |  598 --
 .../drm/amd/display/dc/dml/display_rq_dlg_calc.c   | 1772 ------
 .../drm/amd/display/dc/dml/display_rq_dlg_calc.h   |  148 -
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.h  |    3 +-
 7 files changed, 4 insertions(+), 8611 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.=
c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_calc.=
h


--_000_BN6PR12MB1652474AC2D090E0D3D9C931F7EC0BN6PR12MB1652namp_
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
<br>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.we=
ntland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, January 22, 2018 4:27 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Grodzovsky, Andrey; Cheng, Tony; =
Laktyushkin, Dmytro; Deucher, Alexander<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: dc: Remove unused display_mode_=
vba.c</font>
<div>&nbsp;</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">We're currently not using this.<br>
<br>
v2: More files and includes to remove.<br>
<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dml/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 6 &#43;-<br>
&nbsp;.../gpu/drm/amd/display/dc/dml/display_mode_lib.h&nbsp; |&nbsp;&nbsp;=
&nbsp; 3 -<br>
&nbsp;.../gpu/drm/amd/display/dc/dml/display_mode_vba.c&nbsp; | 6085 ------=
--------------<br>
&nbsp;.../gpu/drm/amd/display/dc/dml/display_mode_vba.h&nbsp; |&nbsp; 598 -=
-<br>
&nbsp;.../drm/amd/display/dc/dml/display_rq_dlg_calc.c&nbsp;&nbsp; | 1772 -=
-----<br>
&nbsp;.../drm/amd/display/dc/dml/display_rq_dlg_calc.h&nbsp;&nbsp; |&nbsp; =
148 -<br>
&nbsp;.../amd/display/dc/dml/dml1_display_rq_dlg_calc.h&nbsp; |&nbsp;&nbsp;=
&nbsp; 3 &#43;-<br>
&nbsp;7 files changed, 4 insertions(&#43;), 8611 deletions(-)<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vb=
a.c<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_mode_vb=
a.h<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_=
calc.c<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/display_rq_dlg_=
calc.h</div>
</span></font><br>
</div>
</body>
</html>

--_000_BN6PR12MB1652474AC2D090E0D3D9C931F7EC0BN6PR12MB1652namp_--

--===============1362850066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1362850066==--

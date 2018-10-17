From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: regression on RV1
Date: Wed, 17 Oct 2018 16:15:21 +0000
Message-ID: <BN6PR12MB180952142479156B7C607F3FF7FF0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <fa0c1c22-5dce-e97f-3e17-59f08bd96f4f@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742860779=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fa0c1c22-5dce-e97f-3e17-59f08bd96f4f-5C7GfCeVMHo@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============1742860779==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180952142479156B7C607F3FF7FF0BN6PR12MB1809namp_"

--_000_BN6PR12MB180952142479156B7C607F3FF7FF0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

IIRC, APUs do not have a paging queue.  Only dGPUs have it.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 17, 2018 11:54:33 AM
To: Koenig, Christian; amd-gfx mailing list
Cc: Huang, Ray
Subject: regression on RV1

This commit:

commit 6cbd074831a423e0d30b386fc056d6c2c3559147 (HEAD, refs/bisect/bad)
Author: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date:   Mon Oct 8 14:38:22 2018 +0200

     drm/amdgpu: activate paging queue on SDMA v4

     Implement all the necessary stuff to get those extra rings working.

     Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

Breaks my RV1 init.

Tom

--_000_BN6PR12MB180952142479156B7C607F3FF7FF0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">IIRC, APUs do not have a paging q=
ueue.&nbsp; Only dGPUs have it.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 17, 2018 11:54:33 AM<br>
<b>To:</b> Koenig, Christian; amd-gfx mailing list<br>
<b>Cc:</b> Huang, Ray<br>
<b>Subject:</b> regression on RV1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This commit:<br>
<br>
commit 6cbd074831a423e0d30b386fc056d6c2c3559147 (HEAD, refs/bisect/bad)<br>
Author: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Mon Oct 8 14:38:22 2018 &#43;0200<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amdgpu: activate paging queue on SDMA v4<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Implement all the necessary stuff to get those ext=
ra rings working.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Christian K=F6nig &lt;christian.koe=
nig-5C7GfCeVMHo@public.gmane.org&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<br>
Breaks my RV1 init.<br>
<br>
Tom<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180952142479156B7C607F3FF7FF0BN6PR12MB1809namp_--

--===============1742860779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1742860779==--

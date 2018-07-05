From: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v3] drm/amdgpu: update documentation for amdgpu_drv.c
Date: Thu, 5 Jul 2018 14:47:07 +0000
Message-ID: <CY4PR12MB1511F4BC97EABF20A34503D8FD400@CY4PR12MB1511.namprd12.prod.outlook.com>
References: <1530728444-32347-1-git-send-email-sonny.jiang@amd.com>,
 <7279fc27-0bba-a818-7682-f4e06815b8da@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1856702220=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7279fc27-0bba-a818-7682-f4e06815b8da-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1856702220==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1511F4BC97EABF20A34503D8FD400CY4PR12MB1511namp_"

--_000_CY4PR12MB1511F4BC97EABF20A34503D8FD400CY4PR12MB1511namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Change it to,

Value 0 is invalidated, will be adjusted to 10000.  Negative values mean 'i=
nfinite timeout' (MAX_JIFFY_OFFSET).


Thanks,

Sonny

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, July 5, 2018 3:30:28 AM
To: Jiang, Sonny; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH v3] drm/amdgpu: update documentation for amdgpu_drv.c

Am 04.07.2018 um 20:20 schrieb Sonny Jiang:
> [SNIP]
>
> +/**
> + * DOC: lockup_timeout (int)
> + * Set GPU scheduler timeout value in ms. It must be > 0.  The default i=
s 10000.
> + */
>   MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms > 0 (default=
 10000)");
>   module_param_named(lockup_timeout, amdgpu_lockup_timeout, int, 0444);

Actually the description here is incorrect, a value of 0 is handled as
infinite timeout IIRC. Please fix while at it.

Apart from that the patch is Acked-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Christian.

--_000_CY4PR12MB1511F4BC97EABF20A34503D8FD400CY4PR12MB1511namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Change it to,</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>Value 0 is invalidated, will be adjusted to 10000.&nbsp; Negative valu=
es mean 'infinite timeout' (MAX_JIFFY_OFFSET).</div>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0">Sonny<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, July 5, 2018 3:30:28 AM<br>
<b>To:</b> Jiang, Sonny; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH v3] drm/amdgpu: update documentation for amdgpu_=
drv.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 04.07.2018 um 20:20 schrieb Sonny Jiang:<br>
&gt; [SNIP]<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/**<br>
&gt; &#43; * DOC: lockup_timeout (int)<br>
&gt; &#43; * Set GPU scheduler timeout value in ms. It must be &gt; 0.&nbsp=
; The default is 10000.<br>
&gt; &#43; */<br>
&gt;&nbsp;&nbsp; MODULE_PARM_DESC(lockup_timeout, &quot;GPU lockup timeout =
in ms &gt; 0 (default 10000)&quot;);<br>
&gt;&nbsp;&nbsp; module_param_named(lockup_timeout, amdgpu_lockup_timeout, =
int, 0444);<br>
<br>
Actually the description here is incorrect, a value of 0 is handled as <br>
infinite timeout IIRC. Please fix while at it.<br>
<br>
Apart from that the patch is Acked-by: Christian K=F6nig <br>
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;.<br>
<br>
Christian.<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1511F4BC97EABF20A34503D8FD400CY4PR12MB1511namp_--

--===============1856702220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1856702220==--

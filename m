From: Bas Nieuwenhuizen <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>
Subject: Re: [RFC]: More robust build sys for UMR
Date: Sun, 05 Feb 2017 14:12:20 +0100
Message-ID: <1486300340.569179.870833952.54395662@webmail.messagingengine.com>
References: <20170205045909.17616-1-funfunctor@folklore1984.net>
 <CY4PR12MB17682A4C6E095C68F9F29A44F7410@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1835141525=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB17682A4C6E095C68F9F29A44F7410-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.

--===============1835141525==
Content-Transfer-Encoding: 7bit
Content-Type: multipart/alternative; boundary="_----------=_14863003405691791"

This is a multi-part message in MIME format.

--_----------=_14863003405691791
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,



I think the current build system is a bit too naive though. On my distro
archlinux the libdrm headers are installed in /usr/include/libdrm, which
causes the include to drm/drm.h in src/lib/query_drm.c to fail.


So if it is in /usr/include/drm on Ubuntu, we are going to need some
autodetection to find the right include path. Autotools definitely
sounds like overkill to me, and the current build system is pretty
simple indeed, but needing to change the source isn't ideal.


By the way, I don't think the current make system handles dependencies
on headers correctly? e.g. if I modify umrapp.h, make rebuilds nothing.
This is one of the things cmake gives you for free, though with a bit of
work make can do it too.


Yours sincerely,

Bas Nieuwenhuizen





On Sun, Feb 5, 2017, at 12:42, StDenis, Tom wrote:

> Hi Edward,



>=20



> Well the patches apply and work but I'm not really sure what problem
> it's meant to solve =F0=9F=98=8A.  Building previously was actually simpl=
er with
> "make" as opposed to "mkdir build && cd build && cmake .. && make".
>=20



> On a BSD system (where this wouldn't really work without the
> corresponding debugfs entries) gmake could be used to build it
> provided ncurses/pciaccess were around.
>=20

> If this legitimately makes it more stable to build on Linux systems
> then I'm all for it.  Can anyone elaborate on where the simple make
> system would fail?
>=20

> (I'm not saying NAK I'm simply asking for my own edification).

>=20

>=20

> Thanks,

> Tom

>=20

>=20

>=20

> *From:* Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org> *Sent:*
> Saturday, February 4, 2017 23:59 *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* StDenis, Tom *Subject:* [RFC]: More robust build sys for UMR
>=20=20

>=20

> Keeping with the tradition of changing the build system on initial
> release, here we go again.. This follow series introduces the cmake
> build system that is intended to be a little more robust across
> various distros and presumably the BSD's also. The installation prefix
> is configurable in the usual cmake way:  `cmake -
> DCMAKE_INSTALL_PREFIX:PATH=3D/usr ..`
>
>  Please kindly review,
>
>  Edward O'Callaghan (4): [PATCH 1/4] cmake_modules: Add libpciaccess
>  finder [PATCH 2/4] cmake: Initial build system [PATCH 3/4] README:
>  minor update for cmake buildsys [PATCH 4/4] drop orginal Makefile &&
>  stub bin/ directory
>=20

> _________________________________________________

> amd-gfx mailing list

> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_----------=_14863003405691791
Content-Transfer-Encoding: 7bit
Content-Type: multipart/related; boundary="_----------=_14863003405691790"

This is a multi-part message in MIME format.

--_----------=_14863003405691790
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="utf-8"

<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body><div>Hi,<br></div>
<div><br></div>
<div>I think the current build system is a bit too naive though. On my dist=
ro archlinux the libdrm headers are installed in /usr/include/libdrm, which=
 causes the include to drm/drm.h in src/lib/query_drm.c to fail.<br></div>
<div><br></div>
<div>So if it is in /usr/include/drm on Ubuntu, we are going to need some a=
utodetection to find the right include path. Autotools definitely sounds li=
ke overkill to me, and the current build system is pretty simple indeed, bu=
t needing to change the source isn't ideal.<br></div>
<div><br></div>
<div>By the way, I don't think the current make system handles dependencies=
 on headers correctly? e.g. if I modify umrapp.h, make rebuilds nothing.&nb=
sp; This is one of the things cmake gives you for free, though with a bit o=
f work make can do it too.<br></div>
<div><br></div>
<div>Yours sincerely,<br></div>
<div>Bas Nieuwenhuizen<br></div>
<div><br></div>
<div><br></div>
<div>On Sun, Feb 5, 2017, at 12:42, StDenis, Tom wrote:<br></div>
<blockquote type=3D"cite"><div style=3D"font-size:12pt;color:rgb(0, 0, 0);f=
ont-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr"><p style=3D"mar=
gin-bottom: 0px; margin-top: 0px;">Hi Edward,<br></p><p style=3D"margin-bot=
tom: 0px; margin-top: 0px;"><br></p><p style=3D"margin-bottom: 0px; margin-=
top: 0px;">Well the patches apply and work but I'm not really sure what pro=
blem it's meant to solve <img alt=3D"=F0=9F=98=8A" style=3D"vertical-align:=
bottom;" src=3D"cid:ffd7d60f-8bdf-497d-86f8-6eb3d733ad74">. &nbsp;Building =
previously was actually simpler with "make" as opposed to "mkdir build &amp=
;&amp; cd build &amp;&amp; cmake .. &amp;&amp; make".<br></p><p style=3D"ma=
rgin-bottom: 0px; margin-top: 0px;"><br></p><p style=3D"margin-bottom: 0px;=
 margin-top: 0px;">On a BSD system (where this wouldn't really work without=
 the corresponding debugfs entries) gmake could be used to build it provide=
d ncurses/pciaccess were around.<br></p><div><br></div>
<div>If this legitimately makes it more stable to build on Linux systems th=
en I'm all for it. &nbsp;Can anyone elaborate on where the simple make syst=
em would fail?<br></div>
<div><br></div>
<div><div>(I'm not saying NAK I'm simply asking for my own edification).<br=
></div>
<div> <br></div>
<div><br></div>
<div>Thanks,<br></div>
<div><div>Tom<br></div>
<div> <br></div>
<div> <br></div>
<div style=3D"color:rgb(0, 0, 0);"><div><div><hr style=3D"display:inline-bl=
ock;width:98%;"><br></div>
<div dir=3D"ltr"><div><span class=3D"colour" style=3D"color:rgb(0, 0, 0)"><=
span class=3D"font" style=3D"font-family:Calibri,&quot; sans-serif&quot;"><=
span class=3D"size" style=3D"font-size:11pt"><b>From:</b> Edward O'Callagha=
n &lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;<br> <b>Sent:</b> Saturday, February 4=
, 2017 23:59<br> <b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br> <b>Cc:</b> St=
Denis, Tom<br> <b>Subject:</b> [RFC]: More robust build sys for UMR</span><=
/span></span> </div>
<div>&nbsp;<br></div>
</div>
</div>
<div><span class=3D"size" style=3D"font-size:small"><span class=3D"size" st=
yle=3D"font-size:10pt"></span></span><br></div>
<div><span class=3D"size" style=3D"font-size:small"><span class=3D"size" st=
yle=3D"font-size:10pt">Keeping with the tradition of changing the build sys=
tem on initial<br> release, here we go again.. This follow series introduce=
s the cmake<br> build system that is intended to be a little more robust ac=
ross<br> various distros and presumably the BSD's also. The installation<br=
> prefix is configurable in the usual cmake way:<br> &nbsp;`cmake -DCMAKE_I=
NSTALL_PREFIX:PATH=3D/usr ..`<br> <br> Please kindly review,<br> <br> Edwar=
d O'Callaghan (4):<br> &nbsp;[PATCH 1/4] cmake_modules: Add libpciaccess fi=
nder<br> &nbsp;[PATCH 2/4] cmake: Initial build system<br> &nbsp;[PATCH 3/4=
] README: minor update for cmake buildsys<br> &nbsp;[PATCH 4/4] drop orgina=
l Makefile &amp;&amp; stub bin/ directory</span></span></div>
<div><span class=3D"size" style=3D"font-size:small"><span class=3D"size" st=
yle=3D"font-size:10pt"></span></span><br></div>
</div>
</div>
</div>
</div>
<div><u>_______________________________________________</u><br></div>
<div>amd-gfx mailing list<br></div>
<div><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br></div>
<div><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br></div>
</blockquote><div><br></div>
</body>
</html>

--_----------=_14863003405691790
Content-Disposition: attachment; filename*=utf-8''OutlookEmoji%2D%F0%9F%98%8A%2Epng
Content-Id: <ffd7d60f-8bdf-497d-86f8-6eb3d733ad74>
Content-Transfer-Encoding: base64
Content-Type: image/png; name="=?utf-8?B?T3V0bG9va0Vtb2ppLfCfmIoucG5n?="

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAGXRFWHRTb2Z0
d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAYpJREFUeNpi/P//PwO1ACM2
wf9njBWAVD4QBwCxApLUAyDeAMQTGU3OPkDRA3QUIxaD+oFUAREOaQQa2IDT
MKBB84FUAgk+WwA0MBFmGBOaixJIDKYEoD6465igBjkge+3CrW94TUCTr4eG
Mdxl8TCZxMYHDIZR1xk2HPiA1SCQOEgepA4J5CMbFgAPhM1vwfTFW9+xGgYT
h6lD1s8IdKIAkH4PEz1w9jOYVpBiZ1CQZMMw7MHzXwwPnv0Esx2MeRESxmcY
WYCUAbJiFAVYAMgCbJbAvPmAWjmACZqS4aHdOOs5wdgEBcWE5a8Y0HIGPAIO
wETtjXkYJqIqxAAgeQM1ThTzkQ2biB5mC7a8xZ7kgeICvMzoYTsRJaMDY3U9
chIBpaMHz34xxPsKgwMcFIsLgckB5KL+YllkgyYAg6oQJW9Ck8h+5NgFhd3G
Ax/humAGI2cGIHYEGvYBW0YHGTgf2YX4MjkQF4IMwlkEIeXVfByGwsqzAwTL
MywGg7wNcvED9AIR3TCAAAMAqh+p+YMVeBQAAAAASUVORK5CYII=

--_----------=_14863003405691790--


--_----------=_14863003405691791--


--===============1835141525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1835141525==--

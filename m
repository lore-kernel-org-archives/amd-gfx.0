From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails
Date: Fri, 12 Aug 2016 15:43:46 +0000
Message-ID: <CAPEhTTHK2uF4r4TuR4Vt4oBD9WsxyoAuwLDQ6bRSmus-BKd1eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1653239347=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alexander Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============1653239347==
Content-Type: multipart/alternative; boundary=94eb2c0550a01eb6920539e1c00e

--94eb2c0550a01eb6920539e1c00e
Content-Type: text/plain; charset=UTF-8

Hi,

While comparing radeon's radeon_afmt_init() to dce_vX_0_afmt_init() on the
amdgpu's side, I saw that on the latter:
1- when kzalloc fails to allocate mem for all afmt, an ENOMEM is returned
2- all previously allocated afmt are freed

So on the amdgpu's side, it is an "all or none allocated" situation, while
on the radeon's side, some afmt may be allocated and initialized.

Moreover, returning an ENOMEM prevents any other function calls in
dce_vX_0_sw_init()
on the amdgpu's side, while it continues on the radeon's side.

What is the expected behavior here? Should we rewind the memory allocation
as it is done under amdgpu when we can't allocate memory for all afmt or is
it OK to do as it is done on radeon? Should we stop any remaining steps in
radeon_modeset_init() if it fails (thus, returning a ENOMEM from
radeon_afmt_init())?

The patch is already ready if needed, I could send it later from home if
the amdgpu's behavior is the one that we are looking for.

Cheers,
Alexandre Demers

--94eb2c0550a01eb6920539e1c00e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>While comparing radeon&#39;s radeon=
_afmt_init() to dce_vX_0_afmt_init() on the amdgpu&#39;s side, I saw that o=
n the latter:</div><div>1- when kzalloc fails to allocate mem for all afmt,=
 an ENOMEM is returned</div><div>2- all previously allocated afmt are freed=
</div><div><br></div><div>So on the amdgpu&#39;s side, it is an &quot;all o=
r none allocated&quot; situation, while on the radeon&#39;s side, some afmt=
 may be allocated and initialized.</div><div><br></div><div>Moreover, retur=
ning an ENOMEM prevents any other function calls in=C2=A0<span style=3D"fon=
t-size:13.3333px;line-height:normal">dce_vX_0_</span><span style=3D"font-si=
ze:13.3333px;line-height:normal">sw_init() on the amdgpu&#39;s side, while =
it continues on the radeon&#39;s side.</span><br></div><div><span style=3D"=
font-size:13.3333px;line-height:normal"><br></span></div><div><span style=
=3D"font-size:13.3333px;line-height:normal">What is the expected behavior h=
ere? Should we rewind the memory allocation as it is done under amdgpu when=
 we can&#39;t allocate memory for all afmt or is it OK to do as it is done =
on radeon? Should we stop any remaining steps in radeon_modeset_init() if i=
t fails (thus, returning a ENOMEM from radeon_afmt_init())?</span></div><di=
v><span style=3D"font-size:13.3333px;line-height:normal"><br></span></div><=
div><span style=3D"font-size:13.3333px;line-height:normal">The patch is alr=
eady ready if needed, I could send it later from home if the amdgpu&#39;s b=
ehavior is the one that we are looking for.</span></div><div><span style=3D=
"font-size:13.3333px;line-height:normal"><br></span></div><div><span style=
=3D"font-size:13.3333px;line-height:normal">Cheers,</span></div><div><span =
style=3D"font-size:13.3333px;line-height:normal">Alexandre Demers</span></d=
iv></div>

--94eb2c0550a01eb6920539e1c00e--

--===============1653239347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1653239347==--

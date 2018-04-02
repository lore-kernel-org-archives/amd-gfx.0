From: Ian Bashford <ianbashford-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Tonga Kernel Modesetting Issue
Date: Mon, 2 Apr 2018 15:29:48 +0100
Message-ID: <CAMqxyLMt=C5xUNuUCTfvXg9Zh_0CTGBPkPw8TNvs0688+7gqKg@mail.gmail.com>
Reply-To: ian-/S0389TiWqnk1uMJSBkQmQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1867389936=="
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1867389936==
Content-Type: multipart/alternative; boundary="94eb2c194f8e1873fa0568de6c6f"

--94eb2c194f8e1873fa0568de6c6f
Content-Type: text/plain; charset="UTF-8"

Hi,
I'm investigating an issue with KMS on my graphics card. I'm hoping this
list might give me some direction/guidance where to look.

Sometime in between kernels 4.9 and 4.14, the KMS on my card stopped
getting set to 2560x1440 and only sets 1920x1080.  Passing video= as a
kernel parameter just leads to a black screen.
I've tried stock kernels on alpine and arch, and also compiled a few as
well; I can't see any obvious differences in the compile options that might
lead to the difference.
My next line of enquiry is to see if there's a change in amdgpu that might
be the cause.
Given the size of the codebase and the number of changes, I was hoping
someone might be able to help me narrow the possible search.

Would you be able to suggest somewhere to begin ?

The card is a Sapphire R9 380X NITRO 4GB  - it identifies as a TONGA.

During the boot, I get this message about the mode setting
[drm] initializing kernel modesetting (TONGA 0x1002:0x6938 0x174B:0xE308
0xF1)

thanks
Ian

--94eb2c194f8e1873fa0568de6c6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div>I&#39;m investigating an issue with KMS on my grap=
hics card. I&#39;m hoping this list might give me some direction/guidance w=
here to look.</div><div><br></div><div>Sometime in between kernels 4.9 and =
4.14, the KMS on my card stopped getting set to 2560x1440 and only sets 192=
0x1080.=C2=A0 Passing video=3D as a kernel parameter just leads to a black =
screen.</div><div>I&#39;ve tried stock kernels on alpine and arch, and also=
 compiled a few as well; I can&#39;t see any obvious differences in the com=
pile options that might lead to the difference.</div><div><span style=3D"co=
lor:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);tex=
t-decoration-style:initial;text-decoration-color:initial;float:none;display=
:inline">My next line of enquiry is to see if there&#39;s a change in amdgp=
u that might be the cause.</span></div><div>Given the size of the codebase =
and the number of changes, I was hoping someone might be able to help me na=
rrow the possible search.</div><div><br></div><div>Would you be able to sug=
gest somewhere to begin ?</div><div><br></div><div>The card is a<font color=
=3D"#000000">=C2=A0</font><span style=3D"font-family:Arial,&quot;Helvetica =
Neue&quot;,Helvetica,sans-serif;font-size:12px;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial;float:none;display:inline"><font c=
olor=3D"#000000">Sapphire R9 380X NITRO 4GB=C2=A0</font><font color=3D"#666=
666"> </font><font color=3D"#000000">- it identifies as a TONGA.</font></sp=
an></div><div><font face=3D"Arial, Helvetica Neue, Helvetica, sans-serif" c=
olor=3D"#000000"><span style=3D"font-size:12px"><br></span></font></div><di=
v><font face=3D"Arial, Helvetica Neue, Helvetica, sans-serif" color=3D"#000=
000"><span style=3D"font-size:12px">During the boot, I get this message abo=
ut the mode setting</span></font></div><div><font face=3D"Arial, Helvetica =
Neue, Helvetica, sans-serif"><span style=3D"font-size:12px"><font color=3D"=
#000000">[drm] initializing kernel modesetting (TONGA 0x1002:0x6938 0x174B:=
0xE308 0xF1)</font></span><br clear=3D"all"></font><div><br></div><div>than=
ks</div><div class=3D"gmail_signature">Ian</div>

</div></div>

--94eb2c194f8e1873fa0568de6c6f--

--===============1867389936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1867389936==--

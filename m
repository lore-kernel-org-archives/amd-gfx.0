From: =?UTF-8?Q?J=C3=A1n_Kosterec?= <johnypean-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: amdgpu fails compilation with CONFIG_FORTIFY_SOURCE
Date: Wed, 5 Sep 2018 20:43:55 +0200
Message-ID: <CANFv0+2=yn983rcLizDEiuDSND9rE4BZuGBeHwZ6J39CC_kgkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000cf0b1a05752428a6"
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

--000000000000cf0b1a05752428a6
Content-Type: multipart/alternative; boundary="000000000000cf0b1605752428a4"

--000000000000cf0b1605752428a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

amdgpu driver fails compilation when compiling with
CONFIG_FORTIFY_SOURCE kernel option:

In function =E2=80=98memmove=E2=80=99,
    inlined from =E2=80=98append_entry=E2=80=99 at
drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.c:258:2,
    inlined from =E2=80=98dm_logger_append_va.part.5=E2=80=99 at
drivers/gpu/drm/amd/amdgpu/../display/dc/basics/logger.c:349:4:
./include/linux/string.h:356:4: error: call to =E2=80=98__read_overflow2=E2=
=80=99
declared with attribute error: detected read beyond size of object
passed as 2nd parameter
    __read_overflow2();
    ^~~~~~~~~~~~~~~~~~

I have attached a patch which resolves this problem.

Regards,
Jan

--000000000000cf0b1605752428a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre class=3D"gmail-bz_comment_text">amdgpu driver fails c=
ompilation when compiling with CONFIG_FORTIFY_SOURCE kernel option:

In function =E2=80=98memmove=E2=80=99,
    inlined from =E2=80=98append_entry=E2=80=99 at drivers/gpu/drm/amd/amdg=
pu/../display/dc/basics/logger.c:258:2,
    inlined from =E2=80=98dm_logger_append_va.part.5=E2=80=99 at drivers/gp=
u/drm/amd/amdgpu/../display/dc/basics/logger.c:349:4:
./include/linux/string.h:356:4: error: call to =E2=80=98__read_overflow2=E2=
=80=99 declared with attribute error: detected read beyond size of object p=
assed as 2nd parameter
    __read_overflow2();
    ^~~~~~~~~~~~~~~~~~

I have attached a patch which resolves this problem.</pre><div><div dir=3D"=
ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div><div=
>Regards,</div><div>Jan</div></div></div></div></div>

--000000000000cf0b1605752428a4--

--000000000000cf0b1a05752428a6
Content-Type: text/x-patch; charset="US-ASCII"; name="amdgpu.patch"
Content-Disposition: attachment; filename="amdgpu.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jlphovxo0>
X-Attachment-Id: f_jlphovxo0

ZGlmZiAtdXIgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9sb2dnZXIuYwotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5jCTIwMTgtMDktMDUg
MTI6Mzc6MTAuODI5NTQ3NzIwICswMjAwCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iYXNpY3MvbG9nZ2VyLmMJMjAxOC0wOS0wNSAxMjozNjo1Mi42MTI2ODIyNTkgKzAyMDAK
QEAgLTM0Niw3ICszNDYsNyBAQAogCQlpZiAoc2l6ZSA8IExPR19NQVhfTElORV9TSVpFIC0gMSkg
ewogCQkJYXBwZW5kX2VudHJ5KGVudHJ5LCBidWZmZXIsIHNpemUpOwogCQl9IGVsc2UgewotCQkJ
YXBwZW5kX2VudHJ5KGVudHJ5LCAiTE9HX0VSUk9SLCBsaW5lIHRvbyBsb25nXG4iLCAyNyk7CisJ
CQlhcHBlbmRfZW50cnkoZW50cnksICJMT0dfRVJST1IsIGxpbmUgdG9vIGxvbmdcbiIsIDI1KTsK
IAkJfQogCX0KIH0K
--000000000000cf0b1a05752428a6
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--000000000000cf0b1a05752428a6--

From: Subsentient <subsentient-Nyw9WiXk/RKDdBA3jUUj6Q@public.gmane.org>
Subject: AMDGPU bug
Date: Sun, 10 Nov 2019 17:00:13 -0700
Message-ID: <8a4cb7112cf6ed44581c838e84306e9c@universe2.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0301415929=="
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

--===============0301415929==
Content-Type: multipart/alternative;
 boundary="=_cff9e4b02e6db70b83fa734ee10aa7f1"

--=_cff9e4b02e6db70b83fa734ee10aa7f1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

Hi, I've been experiencing a bug on kernels 5.2 and up that apparently
is uncommon and/or unimportant enough to have both threads mentioning it
die. 

On a Ryzen 3 2200G, the amdgpu driver fails upon lightdm login: 

https://bugzilla.redhat.com/show_bug.cgi?id=1752188 

I thought I'd bring this to your attention as the others reporting this
bug have so far been met with silence, and this has trapped me and
others on the unsupported kernel 5.1.21. 

Thanks for your time.
--=_cff9e4b02e6db70b83fa734ee10aa7f1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3DUTF-8" /></head><body style=3D'font-size: 10pt; font-family: Verdana,Gen=
eva,sans-serif'>
<p>Hi, I've been experiencing a bug on kernels 5.2 and up that apparently i=
s uncommon and/or unimportant enough to have both threads mentioning it die=
=2E</p>
<p>On a Ryzen 3 2200G, the amdgpu driver fails upon lightdm login:</p>
<p><a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1752188">https:=
//bugzilla.redhat.com/show_bug.cgi?id=3D1752188</a></p>
<p>I thought I'd bring this to your attention as the others reporting this =
bug have so far been met with silence, and this has trapped me and others o=
n the unsupported kernel 5.1.21.</p>
<p>Thanks for your time.</p>
<p><br /></p>

</body></html>

--=_cff9e4b02e6db70b83fa734ee10aa7f1--

--===============0301415929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0301415929==--

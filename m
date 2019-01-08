From: Ilya Trukhanov <lahvuun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Adaptive Sync/VRR not working in multi-head with a non-freesync
 monitor
Date: Tue, 8 Jan 2019 14:41:48 +0200
Message-ID: <20190108124148.GA28230@lahvuun.homenetwork>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0001579327=="
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


--===============0001579327==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Tried Unigine Valley with bspwm and Plasma, Freesync does not get
engaged when second monitor (without Freesync support) is in use.
If I turn it off with e.g.

$ xrandr --output HDMI-A-0 --off

Freesync immediately starts working. Once I turn the monitor back on,
Freesync is gone.


Looking through one of the patches at
https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/merge_requests/5
I found this:

> Per-CRTC support is gone for enabling variable refresh.
> A window must cover the entire X screen in order to flip
> so every CRTC must be enabled or disabled at the same time.

If I understood correctly, in case of multi-head, a window must span
across all monitors, with all monitors having Freesync support.
Therefore, my setup won't work in this case. However, it *does* work on
Windows (albeit only one monitor has Freesync working, obviously).

Am I missing something obvious?
Or is this some kind of X design limitation?
Are there any possible workarounds to achieve the same functionality as
on Windows?


I would greatly appreciate some clarification on this topic. Thank you!

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERcDmQ1GAJW37CHdJz7C5mTm6ygcFAlw0mooACgkQz7C5mTm6
ygdP3w//V16HlNDSnWJt/MVVX1OnWgRJNm4lMygxqUwazrrFa6BOsi5AtaQWwQrn
lyUvN2CFc4UtqeXLL2Sodk78jN3I77eRTziOkUgux6voGjIWd374sfc0tr6hwe/L
2s7ATvM7bclQ6XBG30Q+0z4QTc/5hT08Pp3ROyrVBX3TbaFCc5JQsfMLgCKs5ZSi
r82y1kqzR5ZF52Wsd2AOfv332v0XYyqaEHMp78AsTsuFDR9TkfZRD8gcMqOkj5AK
dCWdz9PS0hdK2kWOfhk1fBuHH6V2MZTOkxOJog3vTpkMMuctb9oSe6wS7UFE5+wG
b39+vF3/ad1L1pstvGneR9u+hUQjUq0gO5mNiipC20UpOyh2SDUDARQMGzvLgkxd
gpEqfnexzKEnYV0X2TN1EyzAnXG8cpj/jGir4fabfOg+VALA1v3x7+bbFQpsoJSg
yTJ3tP3XnLdOsc20VXYppaD3xxywTdck7KgueZPuLcsZhlqv+4jYX4REATyZp0qU
0fDlvEV2XQWPbkgMSWRw7yovb3UcI8JJumru2w80UKIfXWx/+otJsBrZ6l1Ir/hR
5+r4RNewLmqH2qsn4ySVJcGPZxcaH+KY8EhwbCtG3Q4sbb5DfwV2SMcbX2ilKr5D
GaoRnqBSOufSON7aySUJjHoOJvtqfmpA4IiQAC28Kn2KeOH3NcY=
=NWR+
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--===============0001579327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0001579327==--

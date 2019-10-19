From: Qu Wenruo <quwenruo.btrfs-KK0ffGbhmjU@public.gmane.org>
Subject: thunderbolt 3 eGPU related bugs under Linux (1. Unable to hot-unplug,
 2. initialization not properly)
Date: Sat, 19 Oct 2019 21:27:49 +0800
Message-ID: <fc475d0b-a988-d549-c446-cecf64059b5a@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1760236491=="
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1760236491==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KaBrD5u6ywVI7I5PZ1V76BZNrjiV39N40"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KaBrD5u6ywVI7I5PZ1V76BZNrjiV39N40
Content-Type: multipart/mixed; boundary="O30hFYTtsAzEXApjTrMeARy9sLkn5iKtL"

--O30hFYTtsAzEXApjTrMeARy9sLkn5iKtL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for all your awesome works for the full open-source graphic stack.=


But I still find some bugs related to thunderbolt 3 eGPU, which is very
annoying.

- Unable to hot unplug.
  Hot unplug can easily crash the kernel, most like due to some
  BUG_ON().
  This is particularly annoying if the thunderbolt 3 cable is not
  stable.

  I guess it can't be easily fixed anyway, since most PCIE device
  doesn't expect link/physical layer error.

- Initialization is not properly done under Linux only.
  If the GPU is initialized under Linux (no matter hot-plugged in or
  cold boot), although eGPU is properly initialized and detected, the
  display connected to eGPU will just output message indicating
  unacceptable refresh rate.

  The display only accepts refresh rate not higher than 60Hz, and xrandr
  shows the display is at 60Hz, but still, the display doesn't accept
  that signal.
  Also, X11 starts and log shows no obvious problem, but no display.

  The most strange thing is, if the eGPU is initialized under windows
  first, then rebooted into Linux with eGPU, then everything works fine.

  I guess this can be solved.

Hardware info:
- Laptop: ThinkPad X1 Carbon 6th gen
- eGPU box: AORUS gaming box
- eGPU GPU: AORUS RX580 mini

Thanks,
Qu


--O30hFYTtsAzEXApjTrMeARy9sLkn5iKtL--

--KaBrD5u6ywVI7I5PZ1V76BZNrjiV39N40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2rD1UACgkQwj2R86El
/qipYAgApE3SjPkwGIZBHQV/pB40gVNv1ogRVNQJrdbObaxsjwBNsTRAiriuGw/K
QtKE1G5nARP5V5h+fRsLRGU8JuzlQT7gOdbgDYtPTjK5nnRbdqEZRqXutG5BjlIz
YcRChbz/Ir3ZFZbUyWMpvI8Ldn3EaTqLn/AYyvD2tetC4UEGkaYWz18YA+59/eDv
nAFR2bBJQGhUivIrVw+72q9mrFffnrRZpRlflJqQqZEnu2P8CbYA5FBmpsNdyS+u
M0MJqny1HilzCgoTlOO+fiXAAGPJn7ru7vmKzLtrgPriTn7iP6UXXExriLWdYkrl
i+gRwKQQw716prGmctngTvXxLSkWOA==
=pvSX
-----END PGP SIGNATURE-----

--KaBrD5u6ywVI7I5PZ1V76BZNrjiV39N40--

--===============1760236491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1760236491==--

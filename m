From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed
 with error -2 [RESOLVED]
Date: Mon, 24 Jul 2017 13:25:27 +1000
Message-ID: <5497a25c-ca1d-991c-22f7-e270306bd9e4@longlandclan.id.au>
References: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d@longlandclan.id.au>
 <BN6PR12MB1652A30FBDA855022E317794F7A40@BN6PR12MB1652.namprd12.prod.outlook.com>
 <2837c5da-a62c-2f3f-5392-8be270adf8cd@longlandclan.id.au>
 <bc8f3c17-6152-4000-801c-9a3fc9e4044e@daenzer.net>
 <e918c9db-116b-8045-36e4-5d9581575ad2@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1307025959=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e918c9db-116b-8045-36e4-5d9581575ad2-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
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
--===============1307025959==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j7IoOGH0XJq0S8nrbCOrJg9bVV7u7Pm8W"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j7IoOGH0XJq0S8nrbCOrJg9bVV7u7Pm8W
Content-Type: multipart/mixed; boundary="L46sjVWefAdOtvIsH98PigbqikPoMBhcI";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <5497a25c-ca1d-991c-22f7-e270306bd9e4-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed
 with error -2 [RESOLVED]
References: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <BN6PR12MB1652A30FBDA855022E317794F7A40-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
 <2837c5da-a62c-2f3f-5392-8be270adf8cd-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <bc8f3c17-6152-4000-801c-9a3fc9e4044e-otUistvHUpPR7s880joybQ@public.gmane.org>
 <e918c9db-116b-8045-36e4-5d9581575ad2-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
In-Reply-To: <e918c9db-116b-8045-36e4-5d9581575ad2-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>

--L46sjVWefAdOtvIsH98PigbqikPoMBhcI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/07/17 11:55, Stuart Longland wrote:
> Ahh okay, so it's a quirk of having it built into the kernel: it races
> mounting /.  If I get a moment later today I'll try making `amdgpu` a
> module and see how I go.

Right, that fixed it.  Downside with the module loading later is that I
don't get the rookery of penguins (16 of them) showing up on initial
boot, but big deal, it works. :-)

The changes, for anyone else that might strike this issue:
> vk4msl-ws /home/stuartl # diff -u /boot/config-4.13.0-rc1+.old /boot/co=
nfig-4.13.0-rc1+
> --- /boot/config-4.13.0-rc1+.old	2017-07-21 19:25:06.000000000 +1000
> +++ /boot/config-4.13.0-rc1+	2017-07-24 12:40:14.000000000 +1000
> @@ -1712,8 +1712,7 @@
>  CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>  CONFIG_FW_LOADER=3Dy
>  # CONFIG_FIRMWARE_IN_KERNEL is not set
> -CONFIG_EXTRA_FIRMWARE=3D"amdgpu/polaris12_ce.bin amdgpu/polaris12_mc.b=
in amdgpu/polaris12_me.bin amdgpu/polaris12_mec2.bin amdgpu/polaris12_mec=
=2Ebin amdgpu/polaris12_pfp.bin amdgpu/polaris12_rlc.bin amdgpu/polaris12=
_sdma1.bin amdgpu/polaris12_sdma.bin amdgpu/polaris12_smc.bin amdgpu/pola=
ris12_uvd.bin amdgpu/polaris12_vce.bin"
> -CONFIG_EXTRA_FIRMWARE_DIR=3D"/lib/firmware"
> +CONFIG_EXTRA_FIRMWARE=3D""
>  CONFIG_FW_LOADER_USER_HELPER=3Dy
>  # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>  CONFIG_ALLOW_DEV_COREDUMP=3Dy
> @@ -3576,7 +3575,7 @@
>  #
>  # Multifunction device drivers
>  #
> -CONFIG_MFD_CORE=3Dy
> +CONFIG_MFD_CORE=3Dm
>  # CONFIG_MFD_AS3711 is not set
>  # CONFIG_PMIC_ADP5520 is not set
>  # CONFIG_MFD_AAT2870_CORE is not set
> @@ -4339,7 +4338,7 @@
>  CONFIG_DRM_FBDEV_EMULATION=3Dy
>  CONFIG_DRM_FBDEV_OVERALLOC=3D100
>  CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> -CONFIG_DRM_TTM=3Dy
> +CONFIG_DRM_TTM=3Dm
>  CONFIG_DRM_VM=3Dy
> =20
>  #
> @@ -4349,7 +4348,7 @@
>  CONFIG_DRM_I2C_SIL164=3Dm
>  # CONFIG_DRM_I2C_NXP_TDA998X is not set
>  # CONFIG_DRM_RADEON is not set
> -CONFIG_DRM_AMDGPU=3Dy
> +CONFIG_DRM_AMDGPU=3Dm
>  CONFIG_DRM_AMDGPU_SI=3Dy
>  CONFIG_DRM_AMDGPU_CIK=3Dy
>  CONFIG_DRM_AMDGPU_USERPTR=3Dy

Many thanks. :-)
Regards,
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--L46sjVWefAdOtvIsH98PigbqikPoMBhcI--

--j7IoOGH0XJq0S8nrbCOrJg9bVV7u7Pm8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAll1aKwACgkQ+VS7u3lI
1UYUlQ//ZOUBOo3IeDAUrJaaGa9Cfb4zfQ9FenalDWUfW6bt0xvYdvooyH+bpe+/
tSnU5MxSH1a71/VcEkS7S7V8IX3zuTQJBhSisNlmMXyuIuiVMjuHmPscAJFZIvmW
57DN8l8HLTfq8bRYhAI3OqxzAMMD8qj58wW/6KagwiBkhEirPHi9dgi5Cool2Sz4
Ily5hdZ8F/SaTXrBoSPOPLLLqoho/+PqjlUruaOsCq6GVMMgy3D9U6B6YwaA54Ut
VHx4vHAFmgbOt6xHfaZdAEGqOlJlY3xSrOjFoDkMYW6n15J6MCqgk0VXQWiXSSU+
kH9pWGLLcYne0Ls1BhqnhFRL7BCj/V0xzmkx9RPz8YGL2wSZGe1dm+huQit5kSC5
DHXGhI82IIa2DuWk8VRziA6gukdIbRUKxUOdTkcSkqdS3x+fAh4B5Q09UaeadNqJ
eNE1gyQahb2GEzTth5k8ZMmE+PBlRlbzlr2gD0trwmsXcAhPOdmX7B+U0ltxoi2s
s8tehd65h+fL7ZS3IKbSPgHZXFPiK0A93fBdhtGQM58zUrB8HcH0sW8kqJc4vtNb
ZD+leZC5YAChnfng/ZD8I8VgHpSJaDRI5N7qtrBlheNGNFjAFFzL3GLZ4S/doT14
kp+gtOxzSkfYtsz74MYmMbwDMGofCAJR/z4twExYkbQ7cfi50xI=
=kl+d
-----END PGP SIGNATURE-----

--j7IoOGH0XJq0S8nrbCOrJg9bVV7u7Pm8W--

--===============1307025959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1307025959==--

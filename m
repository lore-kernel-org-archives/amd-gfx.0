From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: don't give up if DPM is already running
Date: Mon, 10 Oct 2016 09:12:41 +1100
Message-ID: <cbb76619-3282-a7f2-a2af-04e3e258fd71@folklore1984.net>
References: <1476040988-11676-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0465593773=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476040988-11676-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0465593773==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JflGgj4gxwVMnEIr9a4p3w1PNg11qgWG8"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JflGgj4gxwVMnEIr9a4p3w1PNg11qgWG8
Content-Type: multipart/mixed; boundary="kwq3LVvv1Nj4t7ilKlS09V3V4h9NFdvGr";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <cbb76619-3282-a7f2-a2af-04e3e258fd71-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: don't give up if DPM is already
 running
References: <1476040988-11676-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1476040988-11676-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--kwq3LVvv1Nj4t7ilKlS09V3V4h9NFdvGr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 10/10/2016 06:23 AM, Grazvydas Ignotas wrote:
> Currently the driver crashes if smu7_enable_dpm_tasks() returns early,
> which it does if DPM is already active. It seems to be better just to
> continue anyway, at least I haven't noticed any ill effects. It's also
> unclear at what state the hardware was left by the previous driver, so
> IMO it's better to always fully initialize.
>=20
> Way to reproduce:
> $ modprobe amdgpu
> $ rmmod amdgpu
> $ modprobe amdgpu
> ...
> DPM is already running right now, no need to enable DPM!
> ...
> failed to send message 18b ret is 0
> BUG: unable to handle kernel paging request at ffffed01fc9ab21f
> Call Trace:
>  smu7_set_power_state_tasks+0x499/0x1940 [amdgpu]
>  phm_set_power_state+0xcb/0x120 [amdgpu]
>  psm_adjust_power_state_dynamic+0x11e/0x1b0 [amdgpu]
>  pem_task_adjust_power_state+0xb9/0xd0 [amdgpu]
>  pem_excute_event_chain+0x7d/0xe0 [amdgpu]
>  pem_handle_event_unlocked+0x49/0x60 [amdgpu]
>  pem_handle_event+0xe/0x10 [amdgpu]
>  pp_dpm_dispatch_tasks+0xe0/0x190 [amdgpu]
>  amdgpu_pm_compute_clocks+0x10c/0xc60 [amdgpu]
>  dce_v11_0_crtc_dpms+0x7d/0x150 [amdgpu]
>  dce_v11_0_crtc_disable+0x90/0x4a0 [amdgpu]
>  drm_helper_disable_unused_functions+0x67/0x80 [drm_kms_helper]
>  amdgpu_fbdev_init+0x13e/0x170 [amdgpu]
>  amdgpu_device_init+0x1aeb/0x2490 [amdgpu]
>=20
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index f6afa6a..327030b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -1166,8 +1166,8 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr =
*hwmgr)
> =20
>  	tmp_result =3D (!smum_is_dpm_running(hwmgr)) ? 0 : -1;
>  	PP_ASSERT_WITH_CODE(tmp_result =3D=3D 0,
> -			"DPM is already running right now, no need to enable DPM!",
> -			return 0);
> +			"DPM is already running",
> +			);
> =20
>  	if (smu7_voltage_control(hwmgr)) {
>  		tmp_result =3D smu7_enable_voltage_control(hwmgr);
>=20


--kwq3LVvv1Nj4t7ilKlS09V3V4h9NFdvGr--

--JflGgj4gxwVMnEIr9a4p3w1PNg11qgWG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX+sDZAAoJEP4bvbfZuWjb0PkQAKUszpkPD5shUVaRhedIB4+O
3xEYUqaxGomkX7wM066cVU2s5U2OwK4YukDPNvkKhc5x26tiBM5UsSoGtGcyPbwn
1i/OInifY+UkWvc8LE8R+jHvTQk+YslJNZ3caxs3Zeum20oToAGFewUF1jESp2ai
Zgu1Sg631A+A+/KAQejeW1MaRvTReXjEcfm/J6JWyz7Por8I9x3uLFR8vHFwN70M
fV0xzHMSuJ7dyV/BD58PKQl/cag4iRIoKJjckYJFlDl9WoaMngnCDnapCuFc6q61
cXqmuiWcSdf475nlufcDrpL0L3ZjIZ7eEr4aGdGJ5cE/2GNIkRpB29VpjaLQKVG8
i4PNgDvK/gBMgQqWxuCoVjvQb6c0IOhH/eF+Z/83gM62JZcnH3Wd/AIXvN+FonlY
ZjEzZ4Y1tiwSA5ruk1DCvfvi+la0F+FQTjAOkvEmCxPFj4kJfWjmTeat2kb/Dtoi
tGsQJ22X7A7HEOLhkn86mEsdljaXE0qHk/66LPPLyK3fnBybJQ7Y3CJpRFOaegg7
apqmr1S89OQlbpx3z/e7mSHnw0L0Jg3lO45zSL3PFBbm/j7/fhC0PRAS9ZrUQNzk
Av4w2ivv2Z0WVSLHIu4uOGH/jZECh4SEYaostn8l9enlrk+bX99jn8bDKQBsdLh0
e+eS1h75r9Ria5M7AsQy
=Dlvq
-----END PGP SIGNATURE-----

--JflGgj4gxwVMnEIr9a4p3w1PNg11qgWG8--

--===============0465593773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0465593773==--

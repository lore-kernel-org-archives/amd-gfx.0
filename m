From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: implement raster configuration
Date: Sun, 18 Sep 2016 15:04:30 +1000
Message-ID: <36b4b747-5152-4579-9f21-37e17697c703@folklore1984.net>
References: <1474166210-21736-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0885330280=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1474166210-21736-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0885330280==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m6eeL5IsW2JO2CV5WfAhMDpX7l7lNjDDx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m6eeL5IsW2JO2CV5WfAhMDpX7l7lNjDDx
Content-Type: multipart/mixed; boundary="rkic7BiJ7XhITnCqBBf72bbaDW8n7p3gd";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>
Message-ID: <36b4b747-5152-4579-9f21-37e17697c703-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/3] drm/amdgpu: implement raster configuration
References: <1474166210-21736-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1474166210-21736-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>

--rkic7BiJ7XhITnCqBBf72bbaDW8n7p3gd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/18/2016 12:36 PM, Huang Rui wrote:
> Hi all,
>=20
> This patch set is to introduce the raster configuration for all gfx
> generations.
>=20
> Thanks,
> Rui
>=20
> Huang Rui (3):
>   drm/amdgpu: implement raster configuration for gfx v6
>   drm/amdgpu: implement raster configuration for gfx v7
>   drm/amdgpu: implement raster configuration for gfx v8
>=20
>  drivers/gpu/drm/amd/amdgpu/cikd.h             |  36 ++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 133 ++++++++++++++++++=
+-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 160 ++++++++++++++++++=
+++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 168 ++++++++++++++++++=
+++++++-
>  drivers/gpu/drm/amd/amdgpu/vid.h              |  37 ++++++
>  drivers/gpu/drm/amd/include/asic_reg/si/sid.h |  35 ++++++
>  6 files changed, 566 insertions(+), 3 deletions(-)
>=20


--rkic7BiJ7XhITnCqBBf72bbaDW8n7p3gd--

--m6eeL5IsW2JO2CV5WfAhMDpX7l7lNjDDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX3iBeAAoJEP4bvbfZuWjbYBwQAMp/fXM3FxUgovTdi4CSizCh
rV45AS+gU+tVLWkdToNiBAA6VyTLRFWySiwmpDuKsPnNRE2apUoCZu0MpUAujZtA
H5Q8x84w/GhBrZ1gn02/KkGngIX7nNmx+wYMkwQ0ViwpjkLciXTILgCCPfEqB+bB
1zMQIVUB8EZTl2h/V3aG5410RUOFRQNwP0ply7NEno1b2kSRh7mInGZ9UzxCdsX7
XOCVkeSqp7CfTW6vRO+ZRyY4Wjk+WUDnLym+cvHDqLK0xC1gDsYv+vWtJnoMZHQl
kTvPNNWIcXYbx2N8ESCo/WkjL2e1LEGFZ4Q4pZOdyq1mSMytYwsABjKG4sV0cymY
gyazNE+YoG4xh+MOzXEzX03e6UlQKBO0Eo6bl6DtV9r8EwStbV2c/Ax/7mtolD68
7cdRVcJ9h7GHwUX4IGkK0Dxji/puxweyZpu0wBPqANUY9HE3FCoaYL6fOUelLAOG
GkOr/OcQAsR1TjnqeIQwydhRTfE1F5f7xGKmGWXTapG3ojmBiUzp+wmuyY94Q/6Z
0Z3ncJaoRfn6FSmh1rgaZwfFVR1okz3xpaIuYE3cznI6MXzl1qhLg9jT+QvqQhwt
yvr/FK392k9662XsgDln9hd6q0VhNEGdyAb0NESstdhpWgsGeR6da+PsNXbR/cUd
bynDjRYv9Yc9XIA4BNSr
=KTiO
-----END PGP SIGNATURE-----

--m6eeL5IsW2JO2CV5WfAhMDpX7l7lNjDDx--

--===============0885330280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0885330280==--

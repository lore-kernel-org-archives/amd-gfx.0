From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 00/11] add recovery entity and run queue
Date: Wed, 3 Aug 2016 22:16:51 +1000
Message-ID: <88bda920-4da2-7115-a82c-c0b1f581603e@folklore1984.net>
References: <1470124302-23615-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0609536118=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470124302-23615-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0609536118==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OtrgiHkdArF5utDFjPk6CaUCRtd91G5No"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OtrgiHkdArF5utDFjPk6CaUCRtd91G5No
Content-Type: multipart/mixed; boundary="GU8BTuMnxjOHGlXgLFOmcNGV7n6njuM5f"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <88bda920-4da2-7115-a82c-c0b1f581603e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 00/11] add recovery entity and run queue
References: <1470124302-23615-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470124302-23615-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--GU8BTuMnxjOHGlXgLFOmcNGV7n6njuM5f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I didn't see any of my previous review remarks on your previous
submission addresses in this submission of this series?

Kind Regards,
Edward.

On 08/02/2016 05:51 PM, Chunming Zhou wrote:
> every vm has itself recovery entity, which is used to reovery page tabl=
e from their shadow.
> They don't need to wait front vm completed.
> And also using all pte rings can speed reovery.
>=20
> every scheduler has its own recovery entity, which is used to save hw j=
obs, and resubmit from it, which solves the conflicts between reset threa=
d and scheduler thread when run job.
>=20
> And some fixes when doing this improment.=20
>=20
> Chunming Zhou (11):
>   drm/amdgpu: hw ring should be empty when gpu reset
>   drm/amdgpu: specify entity to amdgpu_copy_buffer
>   drm/amd: add recover run queue for scheduler
>   drm/amdgpu: fix vm init error path
>   drm/amdgpu: add vm recover entity
>   drm/amdgpu: use all pte rings to recover page table
>   drm/amd: add recover entity for every scheduler
>   drm/amd: use scheduler to recover hw jobs
>   drm/amd: hw job list should be exact
>   drm/amd: reset jobs to recover entity
>   drm/amdgpu: no need fence wait every time
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  35 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |  11 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  27 ++++--
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c | 129 +++++++++++++-----=
--------
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |   4 +-
>  9 files changed, 135 insertions(+), 92 deletions(-)
>=20


--GU8BTuMnxjOHGlXgLFOmcNGV7n6njuM5f--

--OtrgiHkdArF5utDFjPk6CaUCRtd91G5No
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXoeCzAAoJEP4bvbfZuWjb+XsQALMWBGH4ZZpFFR113ardzx69
eLj8E32V2dUBvDqDaP657LYwmfa8lc5aqBy0vaxPBttrFedn1o81K8SBZGmizM2G
YaLdpviYjXgeTj7k2WvN0auImiWmG0Zodc6Vt0jmNkQbqxYWlgHXHlcyf6b1AalC
DtY8tWUri7EXyppcMQMDvZ4rOq0qG9qfE1dVjltmlH0ywYW5ew/wvF26r2Wc9O86
MF7LxDyucRctqHVqfPCLwiKfheKRdnpXZN9WjtV5rBfLuAhAmsQ5uueq8XIGvEj4
MC1OxcdRGIDFd+x7V2nCsUlxv7d3K/ddDohNdo2Hif6dmID9FUE4xqE2wgVvapCc
OVOcWBHEtQA0b18m1Y5fm5kJWgeA+1+GaUgbhE+s1ZKOm0Jsq3g/TsRhmgxp31lu
NFAbrsap8xM2Wmf1a9xgkBdmDeDdo+f2FiRh10cR4CmXzRl/4UkzQNAwG9p0IfpO
JWo0Vqdhl7GFelDlzOsSSuJ1ie67bI7zYjCmzdzf4dnobjXApfbhDoFIRA4MTVOe
ecto+J2LOjMghAOA7tVw/IW/8CyUFfLp6wuofE7zu4Uxa7EhAnwJcypwlEDkAFfY
/ZOjR/9t8tiBqU6yy8yEQq6QQTUcr4p3bjyCCn/wzOaeOCTsQrUNQDYTEBGlMyGs
5/QJZ0M0p8tA75yaLWzN
=mpBf
-----END PGP SIGNATURE-----

--OtrgiHkdArF5utDFjPk6CaUCRtd91G5No--

--===============0609536118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0609536118==--

From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: update golden setting of VI
Date: Wed, 3 Aug 2016 22:09:26 +1000
Message-ID: <a47a4a95-147b-5e3b-aadd-57545102ce25@folklore1984.net>
References: <1470115414-23733-1-git-send-email-ray.huang@amd.com>
 <57d13336-f5ae-99f5-5b2d-0c65b8acacd1@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2098434684=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57d13336-f5ae-99f5-5b2d-0c65b8acacd1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
--===============2098434684==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ixvMmtMxqsJ4WAlREmnhOXR6p0gXk4fFU"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ixvMmtMxqsJ4WAlREmnhOXR6p0gXk4fFU
Content-Type: multipart/mixed; boundary="h3lrte0U1klBSG0RVmo1k9M1I1NvFQq3r"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>, Alvin Huan <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>
Message-ID: <a47a4a95-147b-5e3b-aadd-57545102ce25-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: update golden setting of VI
References: <1470115414-23733-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
 <57d13336-f5ae-99f5-5b2d-0c65b8acacd1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
In-Reply-To: <57d13336-f5ae-99f5-5b2d-0c65b8acacd1-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

--h3lrte0U1klBSG0RVmo1k9M1I1NvFQq3r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I forgot to say, if this is clear to everyone else but me you can just
ignore my noise here :p

On 08/03/2016 10:06 PM, Edward O'Callaghan wrote:
> Hi,
>=20
> I think it would be helpful for at least one liner explaining actually
> what is even getting "fixed" here? Obviously we assume, given that you
> work for AMD, these magics are correct however it does help in case of
> issue.
>=20
> Just for a motivating example, suppose a magic is technically correct a=
s
> per hw documentation but there is a bug in the ASIC itself that this
> changed caused a regression with then we would know where/how it occurs=
=2E
>=20
> Kind Regards,
> Edward.
>=20
> On 08/02/2016 03:23 PM, Huang Rui wrote:
>> Hi all,
>>
>> This patch set are all changes of golden setting, mgcg_cgcg setting,
>> tiling mode array and rev id of VI series of cards.
>>
>> Changes from V1 -> V2:
>> - Polaris10 changes are in tonga and polaris11 patches. And fix it.
>>
>> Thanks,
>> Rui
>>
>> Huang Rui (3):
>>   drm/amdgpu: update golden setting of tonga
>>   drm/amdgpu: update golden setting of polaris11
>>   drm/amdgpu: update golden setting of polaris10
>>
>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>=20
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--h3lrte0U1klBSG0RVmo1k9M1I1NvFQq3r--

--ixvMmtMxqsJ4WAlREmnhOXR6p0gXk4fFU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXod72AAoJEP4bvbfZuWjbRtMP/jjVtGMS8CwunSC629qE21DL
93IDO0sCtQpPyP6LlXvjMY2BL4CUAgkNcdMo1ucy9jAIdTf66ZqYgLUX+j59Xyg1
xa4sBuefLAYvnJ5N2iswRbeBb+fNVkf8PhzqIdDSpz3nAB4dkIpthM9DdX3CdF3A
eC8S+P3N6349w5CeE964q+g6VwlCgEkvAGnlzTZRdnH/tbXjzIcCRJEKPlvBvpRC
kdqnfgwm3Z89q8WZLO0WAowpcUMQwrDhqBK+jZnVIcmUenTtodR83Nsq9AGFhRFF
/sN8hKyMctrmTy3xz0dVm7r15lrSK+zl7R76xHL4BGXPd+bU15dd6QbrxL8//c9k
FsoPFHvvb8PbbjreSgkU5RD1M+NR9cRldGMTy+wm0eTkXLh/X1QOyTJkCQ6FKEht
QpKd9adurR277SO0zRySh6aRtRR831qV0+jysgzsL2g624V/mL/2jFRPUgHy4e/n
nxs0ccRS3SUU0dkRrjJrl/aZMP6iVjENGIogfBwWWW7u4LsQE5oUc9x/3ePWBfGF
ZQ+HATITSpzvu4nbbHDWtnkr0UnZ8Y6SmLcoXtUqXDUMjVZRCXFPOhSW/WzTWdZl
TTPS7g/tQBLaEMxTquwahjiW9r/vnr2WyZu5Qq0Olz0t+MAcQYThKx5t82apXO0W
i+WGVJ+GILp5g2B3ApkW
=4tt/
-----END PGP SIGNATURE-----

--ixvMmtMxqsJ4WAlREmnhOXR6p0gXk4fFU--

--===============2098434684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2098434684==--

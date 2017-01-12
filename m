From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: More specific libdrm error message
Date: Thu, 12 Jan 2017 12:29:00 +1100
Message-ID: <2e756ad0-f6b9-7838-c09d-149d7624c529@folklore1984.net>
References: <CY4PR12MB1640D019595EC5A1C6D1F670F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
 <CY4PR12MB16409A6D631EA457A365ECF0F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
 <CY4PR12MB16405027D18941DAF1D35A22F2660@CY4PR12MB1640.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0711893433=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16405027D18941DAF1D35A22F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0711893433==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hqlW9LP4BxBENCBg0bXJTlJpawSJHDXuo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hqlW9LP4BxBENCBg0bXJTlJpawSJHDXuo
Content-Type: multipart/mixed; boundary="RCUF5iEHqxcqNJ4NvfwRarWiNkiMx9FlN";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <2e756ad0-f6b9-7838-c09d-149d7624c529-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: More specific libdrm error message
References: <CY4PR12MB1640D019595EC5A1C6D1F670F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
 <CY4PR12MB16409A6D631EA457A365ECF0F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
 <CY4PR12MB16405027D18941DAF1D35A22F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
In-Reply-To: <CY4PR12MB16405027D18941DAF1D35A22F2660-rpdhrqHFk06q//3LJcutlgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>

--RCUF5iEHqxcqNJ4NvfwRarWiNkiMx9FlN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Xie,

Perhaps you want to use `fprintf(stderr, "...")` over `printf("..")` and
lose the space before the start parenthesis. Also, line wrap
your commit message.

Side note, use git send-email so that the patch is inline and not a HTML
email for easy review and application of the patch.

Kind Regards,
Edward.

On 01/12/2017 08:49 AM, Xie, AlexBin wrote:
> Hi,
>=20
>=20
> v2: Use strerror instead of %m. %m is a GNU C Library extension.
>=20
> Thanks,
>=20
> Alex Bin Xie
>=20
>=20
> -----------------------------------------------------------------------=
-
> *From:* Xie, AlexBin
> *Sent:* Wednesday, January 11, 2017 4:14 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* More specific libdrm error message
> =20
> Hi,
>=20
> Provide more specific error message if non-privileged user runs amdgpu_=
test
>=20
> Before this change, the error message is:" WARNING - Suite
> initialization failed..." People might think this is a driver problem.
>=20
>=20
> Tested with non-privileged user. Now the error message is like.
>=20
> ...
> Error:Permission denied. Hint: Try to run this test program as root.
> WARNING - Suite initialization failed for 'Basic Tests'.
>=20
> ...
>=20
>=20
>=20
> Tested as root with no regression.
>=20
>=20
>=20
> Please review.
>=20
>=20
> Thanks,
>=20
> Alex Bin Xie
>=20
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--RCUF5iEHqxcqNJ4NvfwRarWiNkiMx9FlN--

--hqlW9LP4BxBENCBg0bXJTlJpawSJHDXuo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdtvcAAoJEP4bvbfZuWjb3ZMQAK2rg+//TSHm0PrytA3tef+G
NVnjwmM0jIyMNAXtqF0ZIIYWxeWYeaxnDON/pSGljq8x6/RD5yPtJjXtDl7ewWsa
Ezq/IjgLI/DOozJ8WdBQNhaniz7fC/nzeZDzDnfTMoHYdJU3kXF6YQyUwtbUTBTF
FN99UIn6qfLTKrnVqe8tOvcxszWQJ4B+1X06DtGA5LKfjAVAwIvLzmYJvsIrjprt
ahLQgdQiJbt6PkAYsP97rcBw1P70BMK1+G4f493RwcaTW9SrK4Ae6p9R2E3E73tZ
jMACL+k33f73nxSgnHaaFbBDjhOybx0kBXoa8ixFLEBaD3C/+RJJ4WDso4V5sPwC
fUvvGYoyf2PpoGI2jyzVAmGKrPALC3Axxi3MLODY07V4ybwSaiVvkiBjIYc/pWw3
5cuh2PzHd3Fp3hinSC6tfknwtHCEZJJq8Pn3RPB+jsd/BhrLvrrtz7jSfTzPlpV7
8GJp2XGve6Bl89EnjDg/XsmMjXuHJNPRVD74zC0LiAPJErqCT366ypZ76rhdx/Z1
lnVP3xKJiG/wZ6pVebW6xvjPp+0nZYTqW5FM6cCLfr/lPLjz5rvmDH2VkUk4qOPR
BCFvFy56xjEidtGNfIkH23oJ/sJgi7vvL9YeKBee1QAhyyE1iLScPoTs6rRr8Hcw
1P1d0Sq/q+hef5+V1ceO
=/idL
-----END PGP SIGNATURE-----

--hqlW9LP4BxBENCBg0bXJTlJpawSJHDXuo--

--===============0711893433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0711893433==--

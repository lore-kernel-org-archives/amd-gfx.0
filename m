From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] drm/v3d: Fix calling drm_sched_resubmit_jobs for same
 sched.
Date: Wed, 13 Mar 2019 10:53:21 -0700
Message-ID: <87y35ioe3y.fsf@anholt.net>
References: <1552409822-17230-1-git-send-email-andrey.grodzovsky@amd.com>
 <87imworo9v.fsf@anholt.net>
 <CY4PR12MB1446C0DAFA3349227DEB9B0AEA490@CY4PR12MB1446.namprd12.prod.outlook.com>
 <87lg1ioipw.fsf@anholt.net> <fc067a25-260f-d056-f22c-10d9aac7a612@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0301340748=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fc067a25-260f-d056-f22c-10d9aac7a612-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "dri-devel@lists.freedesktop.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "tomeu@tomeuvizoso.net" <tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org>

--===============0301340748==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

"Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org> writes:

> On 3/13/19 12:13 PM, Eric Anholt wrote:
>> "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org> writes:
>>
>>> They are not the same, but the guilty job belongs to only one {entity,
>>> scheduler} pair and so we mark as guilty only for that particular
>>> entity in the context of that scheduler only once.
>> I get it now, sorry.  I'll merge this through drm-misc-next.
>
> np, i actually pushed it into our internal branch already so you can do=20
> that or wait for our next pull request.

I also fixed the whitespace in the moved code and added the missing
Fixes: line, so I'd like to get it merged through the proper tree for
maintaining v3d.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyJQ5EACgkQtdYpNtH8
nujKqQ//Ve8db5qnRF9zq2K+0M/tZi1r5Ka8YpIsnRrKCBMDSzcxa4Kt+9Xf04qV
Ej9NEoad1dqZdEmVBEk6CFbWvPUqsJB+qDp5StuycK/DzPf/EebmF7rYsRAlBMKN
47XB9XTFVy9GeqBfJabG1qO2O86d5rBSvXq0sD/L5CantbJHaCyZ+t6LdQj+W95O
XYLk7R6OkC0bG5Gslh9OOb51p/G6nSC+t5uR0pG5kPYV2p6tlXvE5pCB9Bk2NiYj
cuWIDTEmI0yltfmnpL9a088g2XByB1LSGa3ityo712yaW3leRhJITlSXE3bzFhyy
r1kRc8DFaD2kV5Z+4P0d8dYBo6ZDmJuA0IOZyAhC82pf6oNrrvVK9NfAirBBiB3B
rYYxp0AnqNXupBhBcg9PIsG3u1dtgwqTp5GpBlxknTspi9YLn8dKSLLGw3q4JioS
JSwBsFF1dP/6gvSjwzTuy5Ve8ddXJ4eDoMj3yIFloe8C8kbR1crKjOd9Pvh/s848
KOEvFyoMO9PLMcul+dk/GNd/uSCUW3gZsaQPpp7Ma4JJpi0mGP2w/MdHAldEkct0
Ssce45DZ00vDoWV1yMKAA4Weh9E59slvuibVXN8fCh7anC6jI/RB8Cff2iwXom8K
xpr/reYQfZAv1SVbcNBPLWLG+fu2iQIqoUMvRyXyTXafb+ODGfY=
=/ohW
-----END PGP SIGNATURE-----
--=-=-=--

--===============0301340748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0301340748==--

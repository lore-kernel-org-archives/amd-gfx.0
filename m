From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] drm/v3d: Fix calling drm_sched_resubmit_jobs for same
 sched.
Date: Tue, 12 Mar 2019 10:33:16 -0700
Message-ID: <87imworo9v.fsf@anholt.net>
References: <1552409822-17230-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082466188=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1552409822-17230-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, tomeu-XCtybt49RKsYaV1qd6yewg@public.gmane.org
Cc: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

--===============0082466188==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org> writes:

> Also stop calling drm_sched_increase_karma multiple times.

Each v3d->queue[q].sched was initialized with a separate
drm_sched_init().  I wouldn't have thought they were all the "same
sched".

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyH7VwACgkQtdYpNtH8
nugc4w/+KemO75rW4QfPkkTpMaaZ3gb3f9p2Ea5sM4SymyBysflvgHcDh5ZqSwqP
kauAbj7qbadONZkrxUQkdOS9IQroYSDOwKjLpC/dz0asJY6v6DR/5Vda7shHHQe1
uN31RpFeYsczfwzomoMcW4Wprslm89CmzJmh3SmPlfZe8LMtP+/AAS2FbaCroXPp
KeH1iW2tzqYv4uBdg/lAkeH/zXbt+Co6VorKIvuSwpMYkIKSujn4onXjyN3KOTKP
aJEh5/qAPkIBGULGwFZA520TKq8eGUoqdfb/hAUX+ndaORJ3jFxKn7hP03DC2/Ci
IZWgCxWNQcvoqeBeNjdql0qf4mm6foj9QWBo8oeNAvJ0nbvwDTZuOWQVmGFpB6vL
riL+QVd8AvLioqTyxCLPGtQ82efJCAjTeQ3GyFknJUIDmZhgVKzOUSLjDqMfonMP
BhKWSy7DuouylJMI2IO52P9CgxbNCFhquWc+oAB/JGiRFbtK6h4BpaXPfPE3vF8t
7UW/KSRnqebvVJNCtIRDZ+BlO9w/aPw85aV7SelcAaEwQ1M/qlp5kt1lL9fShw/O
leh828iVqc4z5q2xawokvnD9xqLru4mfFLNuSFjXMbzf6gVYSG+rqOrJtkf5AgrT
diN04entV99f99Mq6T9cg9Lo3dxzPdMan5SGmQSugltlDw4nKbw=
=v6/X
-----END PGP SIGNATURE-----
--=-=-=--

--===============0082466188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0082466188==--

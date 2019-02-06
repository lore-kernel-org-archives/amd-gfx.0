From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [Intel-gfx] [PATCH 2/6] drm/drv: Prepare to remove
 drm_dev_unplug()
Date: Wed, 06 Feb 2019 10:10:37 -0800
Message-ID: <87y36sss82.fsf@anholt.net>
References: <20190203154200.61479-1-noralf@tronnes.org>
 <20190203154200.61479-3-noralf@tronnes.org>
 <20190204154153.GT3271@phenom.ffwll.local>
 <fd6ab7d7-2f50-14bb-07f4-b25c9fe0892e@tronnes.org>
 <20190205091118.GC3271@phenom.ffwll.local>
 <2162dc93-7454-2358-3b4c-81eaa0e68821@tronnes.org>
 <20190205163144.GF3271@phenom.ffwll.local>
 <db04f763-3fc8-1e80-f184-141f190c472f@tronnes.org>
 <20190206152626.GI3271@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0987772487=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190206152626.GI3271-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

--===============0987772487==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org> writes:
>
> Zooming out more looking at the big picture I'd say all your work in the
> past few years has enormously simplified drm for simple drivers already.
> If we can't resolve this one here right now that just means you "only"
> made drm 98% simpler instead of maybe 99%. It's still an epic win :-)

I'd like to second this.  So many of Noralf's cleanups I think "oof,
that's a lot of work for a little cleanup here".  But we've benefited
immensely from it accumulating over the years.  Thanks again!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxbIx0ACgkQtdYpNtH8
nugzUA//W9y9q2j/UFiPewtfKZX/glPh/3o0TAIBBLdKDb+I8AOQujtmbmodS/uE
s420AfpFjAn/K3xLGx/Zcft4+JzVjgXmU2sYvFLF0sPIk0sknH3gvFiB8B5oHRuw
rNostAQlwggBbQ9bC1ouZyq4KdhCo64RH/sg3W1PfdioSPCC5ePnJZMIUiRgpMHT
JZBecr1OazDhZi2pNqGuj60Tdia1jo8L+d0VdESUlxgEqniO77Zzf98KCA0aJ5jD
STEMxapKN8ZFzFqApTPqLBAwpyWtDY/KyKAnRMDJy9/7LmVLuKp1KhLLwtnz4zuw
5SqTTB+fl+L8x8TQY94PsKMdHK9RQWZbSfuPouZDhyc5FsxZ3V95ZLEi7wpvUO/n
FZ0plrLOF+LNMVBrym/j9mtFjeZ8O1dECrUPplMSkFLpwOqRrgmnRGIJCLUWUm6g
VSYLxn8ymbI1jrQnrWH5hMqTmHtPwA2Avzj/V06f1rFjGriuQPQUXUVRqlzP5CMk
KyfaC6gweE/pHW9vFe2dkDaBmZA7JugPKy33y28bmoBtS0694bExPZw6T8WYO1WT
uz+JbN83gTEq55GvEocIK/6AtX1WzXrte6954L6flJq2Wh7IANIqdUOka048mC7e
DCWk9plTujyyFsTHRFax4+2mRNqSFpXZxA/NC0GKftG39aY35xM=
=CbhE
-----END PGP SIGNATURE-----
--=-=-=--

--===============0987772487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0987772487==--

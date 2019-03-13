From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] drm/v3d: Fix calling drm_sched_resubmit_jobs for same
 sched.
Date: Wed, 13 Mar 2019 09:13:47 -0700
Message-ID: <87lg1ioipw.fsf@anholt.net>
References: <1552409822-17230-1-git-send-email-andrey.grodzovsky@amd.com>
 <87imworo9v.fsf@anholt.net>
 <CY4PR12MB1446C0DAFA3349227DEB9B0AEA490@CY4PR12MB1446.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266556099=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1446C0DAFA3349227DEB9B0AEA490-rpdhrqHFk070Y0OdeIqGUgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0266556099==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

"Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org> writes:

> They are not the same, but the guilty job belongs to only one {entity,
> scheduler} pair and so we mark as guilty only for that particular
> entity in the context of that scheduler only once.

I get it now, sorry.  I'll merge this through drm-misc-next.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyJLDsACgkQtdYpNtH8
nugknxAAqgDLWqNXyFyjoDn8Mkc7TeZGKgTb30lYLCY4gbfrn48BEQxmqcpcXUnI
pIwLcEeVvXhGIycoWWeicNd+tmWxoGRCygcqx/UK3EHtt+Gn44Eu5MAumBYvAJbp
9Gqi/xyEkHn9RDIXl7zRAROhgMO3nCTNPE/BcnAFwlbZ1G9O27urx7NN2Y+sMtk7
dB7OKDeHsjgWB8ueGYHWwzakzvEMJtqmJzDb6/MbPHJmZ0XlX6ZXMsFXRrPnZOic
M6xkYlCXfKmmywaCw9zvgHIO8uiRnSdQtoFpVknBaLZpMpgx/1qoF0U1AzL5VZAx
dy73XB+kcakJmbLOX5Pqh/b2VKllblCfjM5AbILxMVay4ogg+72vo+HjToEhkVI1
2R6v/7St1gtnRnWlfQWjqG7H/x13284pa8E6wmOfmD6bmYLyBcrMCyZ4uWSuX2M5
Mgbgm7BGBGwilspoS+nz4b0vZbTAUXguFoZdv9B3p5MypcT/qHHketYVjyJdUo+S
xnHN6l3yr/pW7m47kuFHftEkS0tyrodQ++zGSCXQgmsSbcfumx2fMo8ROfSHBHHW
ynNm0oPX5CItPEjoEjIl6fHNZB8Hx2ZphlhGJ4PIBtMAolMl4V7mKiYw6k3mJ/IR
92kGF0LNLTXn2YpOiDu4OwdlcKxnXnWyEkSH2HsPtnrlCe9Elw4=
=m2W1
-----END PGP SIGNATURE-----
--=-=-=--

--===============0266556099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0266556099==--

From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [UMR] Add GPU_POWER (v3) + refactored cleanup
Date: Sat, 11 Feb 2017 20:18:36 +0100
Message-ID: <172f8746-d32c-b067-58d9-5227b4e8c6d8@dev.carbon-project.org>
References: <20170211175223.2748-1-tom.stdenis@amd.com>
 <3627d968-1817-5ca3-024e-1d91291680b5@dev.carbon-project.org>
 <2b15805a-3e56-71b7-0242-98e3db103add@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1756505608=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2b15805a-3e56-71b7-0242-98e3db103add-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1756505608==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5TmqCaulOT0PgFQ5Ave04DwXhMCi6g4w4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5TmqCaulOT0PgFQ5Ave04DwXhMCi6g4w4
Content-Type: multipart/mixed; boundary="m81EXlI5KgBIcAbkvUPH6BECjVrlFv7Gm";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <172f8746-d32c-b067-58d9-5227b4e8c6d8-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [UMR] Add GPU_POWER (v3) + refactored cleanup
References: <20170211175223.2748-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <3627d968-1817-5ca3-024e-1d91291680b5-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <2b15805a-3e56-71b7-0242-98e3db103add-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <2b15805a-3e56-71b7-0242-98e3db103add-5C7GfCeVMHo@public.gmane.org>

--m81EXlI5KgBIcAbkvUPH6BECjVrlFv7Gm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Tom,
Tom St Denis wrote on 11.02.2017 20:05:
> On 02/11/2017 01:57 PM, Kai Wasserb=C3=A4ch wrote:
>> Tom St Denis wrote on 11.02.2017 18:52:
>>> I split out the deletion of the unused bits in --top.
>>
>> thank you so much for bearing with me (and Edward, though I can't spea=
k for him,
>> obviously)! You can still have my R-b. ;-)
>>
>> Cheers,
>> Kai
>>
>=20
> No worries.  It's no secret I'm no fan of NFC re-submits but hard to ge=
t upset
> in the face of genuinely good feedback.  And it is a community project =
in the
> long run so it's not like community pushback/feedback is not welcomed (=
my
> rumblings notwithstanding).

I'm not sure what AMD's internal policy might be on this, but NFC re-subm=
its are
usually covered by the "with this/these fixed, you can have my R-b". Whic=
h is
the reason I had that kind of language in there. I didn't expect a resend=
 to the
list, to be honest. (And I would guess the same applied to Edward's R-b.)=


> Thanks to you and Edward for the feedback.
>=20
> I've pushed them out.  You'll need a staging kernel to use GPU_POWER (w=
ith my
> and Eric's patches) to see any of this on a VI dGPU.
>=20
> It's kinda interesting to see the power usage graphs (using umr's --top=
 'logger'
> mode) comparing Polaris10 and fiji while running say unigine-heaven.  I=
 think
> the sensors will help debug/optimize power usage going forward.

Oh, should there have been a DRM version check in there then? Like Mesa g=
uards
some features?

In any case I will have to wait for the Vega-upgrade I'm planning for thi=
s year
to actually test these features out.

Cheers,
Kai


--m81EXlI5KgBIcAbkvUPH6BECjVrlFv7Gm--

--5TmqCaulOT0PgFQ5Ave04DwXhMCi6g4w4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlifY4wACgkQownXbOHe
WdI9kgv8DxkZREJnLZffx+wpHU7mzjqgpkQ26aQGw8dLRondnJEmSXzLngQieFWb
GXMz6zaFgPwTII4G5ba2CstqBdwjqUKu1Ta3+KWlmpytgzHivpYYNSyMd1Eop06Y
PGy1bBQuNLe+bhSfOB3HA39kkXO/pn5cIlapycO2C08Z4GjgJ2FQNiZeBRucLJZ9
Y5X/YmUf56hm3yKQJRouoWsdtnI6V62yZd4rT2A3/gyoLe1bWj6Y/KJG+AtyGX8n
MUohLsotmG8wwgZZHcj1qSEyrhK4oRlL3gYi8FR72My9c2vXHXUYVaLBkd71Syun
A602CUPbQkBBsQT8EC4aXPDwAo8X37z8lRdhGRtP8DIxRGCJGou7vKoFlgMB5KGn
j1Yq8DnSJeJrLU05H6gzIU3LlAqpNnlb5R4iJqG5kX7nPvjZe5tKANvTFSJNK/vC
KK/vr3G5/mJryam9AYBQKWFpiT5AyqmRS9tEPdRg/o+1mRwgKFGPA317HbHOU91O
v8uImxoW
=5STp
-----END PGP SIGNATURE-----

--5TmqCaulOT0PgFQ5Ave04DwXhMCi6g4w4--

--===============1756505608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1756505608==--

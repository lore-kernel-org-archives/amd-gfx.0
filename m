From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 10/12] drm/amd/display: avoid apply_clk_constraints for
 address update
Date: Thu, 8 Dec 2016 17:51:36 +0100
Message-ID: <e3284189-bc14-a2ba-a8a8-a7ba2be3b0cc@dev.carbon-project.org>
References: <20161208012624.8914-1-harry.wentland@amd.com>
 <20161208012624.8914-11-harry.wentland@amd.com>
 <3b1b2891-1d61-3592-af23-c8a7034a7d05@dev.carbon-project.org>
 <6d3c6747-e68e-2891-c304-90b9d76d3c9a@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0739506902=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6d3c6747-e68e-2891-c304-90b9d76d3c9a-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0739506902==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="doniqffBRJi7c5OLkcfinWb0RhFA9lmIQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--doniqffBRJi7c5OLkcfinWb0RhFA9lmIQ
Content-Type: multipart/mixed; boundary="r5jGo6RDDMvKIJXFAb8qEHh5XvpAr6Dtx";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>
Message-ID: <e3284189-bc14-a2ba-a8a8-a7ba2be3b0cc-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 10/12] drm/amd/display: avoid apply_clk_constraints for
 address update
References: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <20161208012624.8914-11-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <3b1b2891-1d61-3592-af23-c8a7034a7d05-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <6d3c6747-e68e-2891-c304-90b9d76d3c9a-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <6d3c6747-e68e-2891-c304-90b9d76d3c9a-5C7GfCeVMHo@public.gmane.org>

--r5jGo6RDDMvKIJXFAb8qEHh5XvpAr6Dtx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Harry Wentland wrote on 08.12.2016 17:47:
> Alex's tree isn't fully in sync yet.
>=20
> This is currently only used by code for unreleased ASICs, so the public=
 code
> won't use it (yet).

ok, though that seems turned around. Why not squash this into the enablem=
ent
series for the as of yet unreleased ASICs ("uGPU" from the other thread, =
I assume?)

Cheers,
Kai

> On 2016-12-08 11:39 AM, Kai Wasserb=C3=A4ch wrote:
>> [Please CC me on all replies, I'm not subscribed to the list.]
>>
>> Harry Wentland wrote on 08.12.2016 02:26:
>>> From: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>
>>>
>>> - dc_update_surfaces_for_target get called in ISR but apply_clk_const=
raints
>>> allocates memory
>>>
>>> Change-Id: I9f4b7b6ca4af27c35c007e3af95111081a77d242
>>> Signed-off-by: Tony Cheng <tony.cheng-5C7GfCeVMHo@public.gmane.org>
>>> Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>
>>> Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> index 70b7673993b2..522ef7047564 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>> @@ -1336,6 +1336,7 @@ void dc_update_surfaces_for_target(struct dc *d=
c,
>>> struct dc_surface_update *upda
>>>       int i, j;
>>>       bool is_new_pipe_surface[MAX_PIPES];
>>>       const struct dc_surface *new_surfaces[MAX_SURFACES] =3D { 0 };
>>> +    bool need_apply_clk_constraints =3D false;
>>>         update_surface_trace(dc, updates, surface_count);
>>>   @@ -1405,6 +1406,7 @@ void dc_update_surfaces_for_target(struct dc =
*dc,
>>> struct dc_surface_update *upda
>>>                 if (updates[i].plane_info || updates[i].scaling_info
>>>                       || is_new_pipe_surface[j]) {
>>> +                need_apply_clk_constraints =3D true;
>> Where is this variable used? I grepped through the tree at
>> <https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd?h=3D=
amd-staging-4.7>,
>>
>> but couldn't find it anywhere and it doesn't get passed anywhere from =
here. Or
>> are there patches missing in Alex' tree?
>>
>> Cheers,
>> Kai
>>
>>>                   if (updates[i].plane_info) {
>>>                       surface->public.color_space =3D
>>>
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--=20

Kai Wasserb=C3=A4ch (Kai Wasserbaech)

E-Mail: kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org


--r5jGo6RDDMvKIJXFAb8qEHh5XvpAr6Dtx--

--doniqffBRJi7c5OLkcfinWb0RhFA9lmIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlhJj5gACgkQownXbOHe
WdIg+gv/QzWCCX01VW3m4NJCRhqdIiAq86vS0eG2p0Ml/nzoFC7QIU67Dgadgq4K
kiZ4WEZhegmxsbtfZPEq4FJ0fsg2m5CtkmXTiS9l3okXH7nEFgu32n77va1N6vJS
lgDlGBi4KxHVII086hmWQbLUAiYYINkvFYUx0muBFHFSfHN0bncgeBDGHP/Jjoy7
+KDtVZzy8yaxKlgsLDdPFDWzUlOojKTO23p3GeyX9Z06y/YlRQ6+2GoIjcmR5igM
4M+EFRng73S+3dlNikHPccTBGLwQkIdwKCE9LkAv/sUL7vNb0S15+JQm+taTfp4q
UJgu0xdxRdtysHVjnkJNKGmJqlGMbP0ms2N7xlR/R1Fi9FH3eBs4BS1nqM3tI3bG
qqwxbk5qVA3yN2HpEkuJTtbQsoe1akzSwq7Qge/Nc78YbQ4hEupDJkmSkcr+K5Bk
qJpBNZwyhIRWo0rNEv2vx+u7Jhnox3yF0mSeVcLEM244Qpb8pIZjHaNYdkZHSLP7
p99vSjNf
=J7+T
-----END PGP SIGNATURE-----

--doniqffBRJi7c5OLkcfinWb0RhFA9lmIQ--

--===============0739506902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0739506902==--

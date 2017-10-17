From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: amdgpu: DRI3 with EGL?
Date: Tue, 17 Oct 2017 16:52:13 +0200
Message-ID: <ccdd88ad-165c-9a33-8617-2cf7fdb24a42@dev.carbon-project.org>
References: <c3bc7d1d-37d0-c194-5bf7-535949ef194b@dev.carbon-project.org>
 <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c@daenzer.net>
 <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f@dev.carbon-project.org>
 <81f4151e-f638-789c-8c7c-a450830a8b79@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1106375737=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <81f4151e-f638-789c-8c7c-a450830a8b79-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1106375737==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OQvpbLaitaOqfNMKjc8VwePgJ7SwQ6usr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OQvpbLaitaOqfNMKjc8VwePgJ7SwQ6usr
Content-Type: multipart/mixed; boundary="8KrJ3xeJ1GoE6Btfa9jcDv95hbKaXiqTb";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <ccdd88ad-165c-9a33-8617-2cf7fdb24a42-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: amdgpu: DRI3 with EGL?
References: <c3bc7d1d-37d0-c194-5bf7-535949ef194b-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <e5ffcce1-4e8f-e00d-82ee-5b95cab2282c-otUistvHUpPR7s880joybQ@public.gmane.org>
 <d48e9c96-83fd-de4c-0d70-ade8e6b1bd4f-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <81f4151e-f638-789c-8c7c-a450830a8b79-otUistvHUpPR7s880joybQ@public.gmane.org>
In-Reply-To: <81f4151e-f638-789c-8c7c-a450830a8b79-otUistvHUpPR7s880joybQ@public.gmane.org>

--8KrJ3xeJ1GoE6Btfa9jcDv95hbKaXiqTb
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Dear Michel,
Michel D=C3=A4nzer wrote on 17.10.2017 11:20:
> On 16/10/17 06:21 PM, Kai Wasserb=C3=A4ch wrote:
>> Michel D=C3=A4nzer wrote on 16.10.2017 18:05:
>>> On 16/10/17 05:53 PM, Kai Wasserb=C3=A4ch wrote:
>>>> [...]
>>>>
>>>> But when I look at my Xorg.0.log or the output of eglinfo, I see the=
 following
>>>> lines:
>>>> - Xorg.0.log:	[    15.305] (II) glamor: EGL version 1.5 (DRI2):
>>>> - eglinfo:	EGL version string: 1.5 (DRI2)
>>>>
>>>> My understanding was, that amdgpu supports DRI3 for quite some time =
now and
>>>> therefore would expect to see something like "EGL version string: 1.=
5 (DRI3)".
>>>>
>>>> What am I missing?
>>>
>>> Only that those messages are about a different "DRI2" than the
>>> alternative to DRI3.
>>
>> ah, I was not aware of that. What =E2=80=9EDRI=E2=80=9C is meant here =
then?
>=20
> The API exposed by *_dri.so to the EGL runtime. It's called "DRI2"
> because it had to be changed from the original API when DRI2 was
> introduced. However, that wasn't necessary for DRI3.

thank you for the explanation! Is there any chance that this could be
disambiguated? Maybe by adding a =E2=80=9EMESA-=E2=80=9C to the string, w=
hich is returned as the
EGL version string. Would a "patch" for this be welcome?

Cheers,
Kai


--8KrJ3xeJ1GoE6Btfa9jcDv95hbKaXiqTb--

--OQvpbLaitaOqfNMKjc8VwePgJ7SwQ6usr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlnmGSIACgkQownXbOHe
WdJxHwwAwgwz2rHHsEEfSkh5skZGEH0kei3UtBg7csL4jyRv5W8OChEMJh6AEzDl
SOBZoAjGCt5knzs8KO51YaOYk02hv0dmaCUn2HFkUeJbTyuSqbHXi/wKuwzFjcQ+
tb1sI+nh/FQgueiRcowRnkLwUH596Vjhn9zel177pO7KrG3g5QQv108o4OEhf0NH
UH9n+3I92IXr869b6Y6Di8cYBI0cdsU2OEvXY0t6Dmy+Yo7TAbvpKvNUh/tpJcKB
UHnzGYgVaI3Zgpg7KS+VpVPHODYpKP2h/q1jImn4QTHT2ws2QOpGebwNvILmHzyK
M9VlshwaBILG5DhryVE0OcbRz2QL8BExDcKsnEQbjNiTrxabUVsOedbLmkS7T6y8
Tl9tBxdbgGuw+1VarDuRagn7gaOFfqHnIn8hjqUADtVezpftv1oVMVqeXFxrq7dV
izRG9pIV7Z3mGeV7+PJKmYwavXhgh9WW2paAn9Vn1qvPIRUp9aj88y6kONGqyp6g
QJ48Bz02
=E5vA
-----END PGP SIGNATURE-----

--OQvpbLaitaOqfNMKjc8VwePgJ7SwQ6usr--

--===============1106375737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1106375737==--

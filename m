From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: Video memory reported by GLX_MESA_query_renderer differs between
 amdgpu and radeon
Date: Sat, 10 Dec 2016 22:52:31 +0100
Message-ID: <559285e9-390b-9a09-6a31-ab8163a79dd9@dev.carbon-project.org>
References: <dfe0d8dd-81fb-8703-61c8-e1a17ba7c9c4@dev.carbon-project.org>
 <CADnq5_MTiL3GhPMWU8pjFxLaj+2xFtbT9+_vL6zkLhswQgDTnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2051617258=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MTiL3GhPMWU8pjFxLaj+2xFtbT9+_vL6zkLhswQgDTnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2051617258==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7kGvqS5gQwHbSpQigg4dMI8tf2jMvDduf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7kGvqS5gQwHbSpQigg4dMI8tf2jMvDduf
Content-Type: multipart/mixed; boundary="kGxBG0FBxSL3waMHfjaR94gXjxhCAB0dF";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Message-ID: <559285e9-390b-9a09-6a31-ab8163a79dd9-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: Video memory reported by GLX_MESA_query_renderer differs between
 amdgpu and radeon
References: <dfe0d8dd-81fb-8703-61c8-e1a17ba7c9c4-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
 <CADnq5_MTiL3GhPMWU8pjFxLaj+2xFtbT9+_vL6zkLhswQgDTnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CADnq5_MTiL3GhPMWU8pjFxLaj+2xFtbT9+_vL6zkLhswQgDTnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--kGxBG0FBxSL3waMHfjaR94gXjxhCAB0dF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[Please CC me on all replies, I'm not subscribed to this list.]

Dear Alex,
Alex Deucher wrote on 10.12.2016 22:40:
> On Fri, Dec 9, 2016 at 3:27 PM, Kai Wasserb=C3=A4ch
> <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org> wrote:
>> [Please CC me on all replies, I'm not subscribed to this list.]
>>
>> Hey,
>> I've been noticing that GLX_MESA_query_renderer reports less video mem=
ory when I
>> use amdgpu for my Hawaii PRO GPU, than when I use radeon. Since I'm pr=
etty happy
>> with amdgpu (as I do not use HDMI audio) and it's the code, that gets =
active
>> improvements, I'd like to stay with it, but having 40 MB of video memo=
ry
>> "vanish" is not nice.
>> With radeon GLX_MESA_query_renderer reports 4096 MB RAM (as expected, =
the R9 290
>> was sold/advertised with that), while I'm seeing 4056 MB with amdgpu (=
last
>> tested kernel: 4.8.13).
>>
>> As I'm not sure, whether this is a bug or rather some always reserved =
memory
>> area, which gets subtracted before reporting the available memory, I d=
idn't file
>> a bug report and rather am writing this e-mail. If it's a bug I'm happ=
y to file
>> the report against amdgpu.
>=20
> IIRC, the driver interfaces used to get the information exposed via
> that extension are slightly different.  radeon exposes the total
> amount of vram while amdgpu reports the total amount of free vram.
> The actual amount of free vram is probably pretty close.

thanks for the explanation!

But I'd like to point out that some of the automatic configuration tools =
shipped
with games (and probably other programs) are deciding upon the reported v=
alues
to which quality level they should default. Maybe reporting the theoretic=
al VRAM
might be better (you could always report the actual values through sysfs =
or some
other channel)?

Cheers,
Kai


--kGxBG0FBxSL3waMHfjaR94gXjxhCAB0dF--

--7kGvqS5gQwHbSpQigg4dMI8tf2jMvDduf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlhMeR8ACgkQownXbOHe
WdLLyAwAkABW9Q4l0yGVFfu6dzuJO2XS8vj1/o4sKqJqgwdz3ByMVw6Gw1JF6y7A
KY1WwpDvx8NPrQUWMSu2ZTJJbk9Qn3zfd3OZfdE1xWygD0yRYCCCLfuT+iMKp2BW
yL9qUrsSafs66aiatnaQS8JmcZt9n+xg78jjn6+HrNRWwn4JHKVkw7cB16BfjlkY
DEx0IaLPRYGA5NiYBRm4wcXaYnaU7IqAmpQTAQAn59Lf3FJucKavZSBulTm9O+2+
uG7jWnG8SiKU4ne8iGOlhAqPvbjQ4Vt7ylz2ZEC2KPr3mvV0sez4aBI+ymbKZyXT
j1S1toEi5i4iC5+CfzBgJYyBmx/2MNy0y6tp6GhAtJKixrRmGovLUoMq8APZDivO
YrqrhaVte5mqtCyDhCRYwoXOk+9A8uszc7ndyFrXchsFBT5clbaYPgKX7qmhnOal
FDYc9KWxeWOp9HNm0y/XJF4GrPosprOlQvoqQ9YhBvXV41uLQ19WF04vHEepZKol
3qF/UZuA
=RZ0H
-----END PGP SIGNATURE-----

--7kGvqS5gQwHbSpQigg4dMI8tf2jMvDduf--

--===============2051617258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2051617258==--

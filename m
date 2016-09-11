From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/amdkfd: Make kfd_lookup_process_by_pasid() well
 defined
Date: Sun, 11 Sep 2016 15:46:01 +1000
Message-ID: <86cde692-521f-5020-b0e1-2ecf800efba9@folklore1984.net>
References: <1473471099-16914-1-git-send-email-funfunctor@folklore1984.net>
 <1473471099-16914-5-git-send-email-funfunctor@folklore1984.net>
 <CAFCwf133N=8Eq1QJG-tO8WTFE2=7zKLJHV9GzHu-NWpKwTdQVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1359664884=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf133N=8Eq1QJG-tO8WTFE2=7zKLJHV9GzHu-NWpKwTdQVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1359664884==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DExDxUPx3GGfonCxt4XeSPurwucuI8uvi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DExDxUPx3GGfonCxt4XeSPurwucuI8uvi
Content-Type: multipart/mixed; boundary="kuJNuiPf9sl8Oaf5pf8p0HBPENjVrPD15";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <86cde692-521f-5020-b0e1-2ecf800efba9-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 4/7] drm/amdkfd: Make kfd_lookup_process_by_pasid() well
 defined
References: <1473471099-16914-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <1473471099-16914-5-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <CAFCwf133N=8Eq1QJG-tO8WTFE2=7zKLJHV9GzHu-NWpKwTdQVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAFCwf133N=8Eq1QJG-tO8WTFE2=7zKLJHV9GzHu-NWpKwTdQVQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--kuJNuiPf9sl8Oaf5pf8p0HBPENjVrPD15
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/11/2016 01:55 AM, Oded Gabbay wrote:
> On Sat, Sep 10, 2016 at 4:31 AM, Edward O'Callaghan
> <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org> wrote:
>> Ensure we return a NULL on the fail branch so that the call
>> site may BUG_ON() it.
>>
>> Signed-off-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_process.c
>> index 4f3849a..8d78052 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -481,13 +481,14 @@ bool kfd_has_process_device_data(struct kfd_proc=
ess *p)
>>  /* This returns with process->mutex locked. */
>>  struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid)
>>  {
>> -       struct kfd_process *p;
>> +       struct kfd_process *p, *ret_p =3D NULL;
>>         unsigned int temp;
>>
>>         int idx =3D srcu_read_lock(&kfd_processes_srcu);
>>
>>         hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)=
 {
>>                 if (p->pasid =3D=3D pasid) {
>> +                       ret_p =3D p;
>>                         mutex_lock(&p->mutex);
>>                         break;
>>                 }
>> @@ -495,5 +496,5 @@ struct kfd_process *kfd_lookup_process_by_pasid(un=
signed int pasid)
>>
>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>
>> -       return p;
>> +       return ret_p;
>>  }
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20
> This patch is not needed. p will always be a valid pointer on return or=
 NULL.
> Unless we hit the "p->pasid =3D=3D pasid" condition, in which case p is=

> valid, p will always be NULL when finishing the hash_for_each_rcu
> macro.

Ah you are correct, I didn't notice it was initialized inside the macro.

>=20
>         Oded
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--kuJNuiPf9sl8Oaf5pf8p0HBPENjVrPD15--

--DExDxUPx3GGfonCxt4XeSPurwucuI8uvi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX1O+dAAoJEP4bvbfZuWjbRJgP/i/6b9jJVZXyuSXAUUfbM6g6
6zc1NGt/xDhfTTDqW9XkMMH2lmm7XrVBgsiMqFDJNpDrrzvE7PPOb6YTpp0mVkO9
kAY9Wu3EJFuO/UomRdWfZyv9ObDJ7+bdTh6jZGUib4bt5T/4cbLFrkePXBe3+V1g
3UTAkswdKPzr1M28d4KqBVpi8Ymw8J8ZVlq3jJmSc+oJd6i8k8S+vySnL31BCx3T
kfadXSOhxM05vHnUO6cBBdcBkzXMpZSsBBrVZHqzDvyaf2JQGRiBjpWTfMN4Z9dQ
XECgJhZaSGjPh1xmIm9cYkwTI9nbh3Cty9wtlAtt2JQIzOi9wn3wrRncjVVd+v8J
cZViHF6t2c6Yzhx65mTOJCEte+XLV2q/st0wWhn1LN1xh4TH1hPTgT7Eb92d4RUq
e/+CeMzNaU0U/wuTQQixlM+IsR/7+lkDr3dv6BDkE2XPXyTB8Ku5Vij7aiRQmsan
djW9hTH4VnvT0MrqgWyOaowaeuVIFoENZcfMTXq7a+4tTlKsAXprynrsZkJaEJMt
M7MyZExPI+ofjc8ppSBQueXqTAqAaCCepXH74gjaAtiPP4xozD9Fwa8yZpHj7cle
89gxkZZMTUiI0s2QSVf6CiPtorReKhLWnC9KQKBmCh6DBDqxpQpRXa+iMI93Usi1
rgUgRBGT3LXmLK+ZsEeR
=1SIH
-----END PGP SIGNATURE-----

--DExDxUPx3GGfonCxt4XeSPurwucuI8uvi--

--===============1359664884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1359664884==--

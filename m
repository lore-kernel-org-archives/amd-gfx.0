From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Decode bit fields in 'cik_ih_ring_entry'
 directly
Date: Tue, 27 Sep 2016 23:37:46 +1000
Message-ID: <5fe11925-0570-8a3a-fd0d-66073290c433@folklore1984.net>
References: <1474980460-8743-1-git-send-email-funfunctor@folklore1984.net>
 <1474980460-8743-3-git-send-email-funfunctor@folklore1984.net>
 <856c4498-9096-6a02-9e9a-c97e7f313252@vodafone.de>
 <CY4PR12MB17680FE69F96B2B57A1161EEF7CC0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2120577582=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB17680FE69F96B2B57A1161EEF7CC0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2120577582==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WjkB6XvNKsHICSr79qWuVlVRMqiBuUmSu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WjkB6XvNKsHICSr79qWuVlVRMqiBuUmSu
Content-Type: multipart/mixed; boundary="PfXR0o4XQMOIAAenHiphpTGbmn1Qnj889";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <5fe11925-0570-8a3a-fd0d-66073290c433-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: Decode bit fields in 'cik_ih_ring_entry'
 directly
References: <1474980460-8743-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <1474980460-8743-3-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <856c4498-9096-6a02-9e9a-c97e7f313252-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
 <CY4PR12MB17680FE69F96B2B57A1161EEF7CC0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
In-Reply-To: <CY4PR12MB17680FE69F96B2B57A1161EEF7CC0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>

--PfXR0o4XQMOIAAenHiphpTGbmn1Qnj889
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Excellent point Christian, it did occur to me that endianness could be a
problem so will definitely fix this one up as Tom suggested.

Kind Regards,
Edward.

On 09/27/2016 11:02 PM, StDenis, Tom wrote:
> Better would be to add them to a bitmask header and then use
> REG_GET_FIELD() so it's nice and clean looking.
>=20
>=20
> Tom
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> Christian K=C3=B6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Tuesday, September 27, 2016 08:52
> *To:* Edward O'Callaghan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 2/2] drm/amdkfd: Decode bit fields in
> 'cik_ih_ring_entry' directly
> =20
> NAK, don't use bitfields to decode hardware values. They aren't portabl=
e.
>=20
> Regards,
> Christian.
>=20
> Am 27.09.2016 um 14:47 schrieb Edward O'Callaghan:
>> Signed-off-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 15 +++++---------=
-
>>   drivers/gpu/drm/amd/amdkfd/cik_int.h             | 20 ++++++++++++++=
++----
>>   2 files changed, 21 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/driver=
s/gpu/drm/amd/amdkfd/cik_event_interrupt.c
>> index 211fc48..1c47b9e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
>> @@ -27,14 +27,12 @@
>>   static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>>                                        const uint32_t *ih_ring_entry)
>>   {
>> -     unsigned int pasid;
>>        const struct cik_ih_ring_entry *ihre =3D
>>                        (const struct cik_ih_ring_entry *)ih_ring_entry=
;
>>  =20
>> -     pasid =3D (ihre->ring_id & 0xffff0000) >> 16;
>>  =20
>>        /* Do not process in ISR, just request it to be forwarded to WQ=
=2E */
>> -     return (pasid !=3D 0) &&
>> +     return (ihre->pasid !=3D 0) &&
>>                (ihre->source_id =3D=3D CIK_INTSRC_CP_END_OF_PIPE ||
>>                ihre->source_id =3D=3D CIK_INTSRC_SQ_INTERRUPT_MSG ||
>>                ihre->source_id =3D=3D CIK_INTSRC_CP_BAD_OPCODE);
>> @@ -43,21 +41,18 @@ static bool cik_event_interrupt_isr(struct kfd_dev=
 *dev,
>>   static void cik_event_interrupt_wq(struct kfd_dev *dev,
>>                                        const uint32_t *ih_ring_entry)
>>   {
>> -     unsigned int pasid;
>>        const struct cik_ih_ring_entry *ihre =3D
>>                        (const struct cik_ih_ring_entry *)ih_ring_entry=
;
>>  =20
>> -     pasid =3D (ihre->ring_id & 0xffff0000) >> 16;
>> -
>> -     if (pasid =3D=3D 0)
>> +     if (ihre->pasid =3D=3D 0)
>>                return;
>>  =20
>>        if (ihre->source_id =3D=3D CIK_INTSRC_CP_END_OF_PIPE)
>> -             kfd_signal_event_interrupt(pasid, 0, 0);
>> +             kfd_signal_event_interrupt(ihre->pasid, 0, 0);
>>        else if (ihre->source_id =3D=3D CIK_INTSRC_SQ_INTERRUPT_MSG)
>> -             kfd_signal_event_interrupt(pasid, ihre->data & 0xFF, 8);=

>> +             kfd_signal_event_interrupt(ihre->pasid, ihre->data & 0xF=
F, 8);
>>        else if (ihre->source_id =3D=3D CIK_INTSRC_CP_BAD_OPCODE)
>> -             kfd_signal_hw_exception_event(pasid);
>> +             kfd_signal_hw_exception_event(ihre->pasid);
>>   }
>>  =20
>>   const struct kfd_event_interrupt_class event_interrupt_class_cik =3D=
 {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_int.h b/drivers/gpu/drm/am=
d/amdkfd/cik_int.h
>> index 79a16d2..27d1ede 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/cik_int.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/cik_int.h
>> @@ -26,10 +26,22 @@
>>   #include <linux/types.h>
>>  =20
>>   struct cik_ih_ring_entry {
>> -     uint32_t source_id;
>> -     uint32_t data;
>> -     uint32_t ring_id;
>> -     uint32_t reserved;
>> +     uint32_t source_id:8;
>> +     uint32_t reserved1:8;
>> +     uint32_t reserved2:16;
>> +
>> +     uint32_t data:28;
>> +     uint32_t reserved3:4;
>> +
>> +     /* pipeid, meid and unused3 are officially called RINGID,
>> +      * but for our purposes, they always decode into pipe and ME. */=

>> +     uint32_t pipeid:2;
>> +     uint32_t meid:2;
>> +     uint32_t reserved4:4;
>> +     uint32_t vmid:8;
>> +     uint32_t pasid:16;
>> +
>> +     uint32_t reserved5;
>>   };
>>  =20
>>   #define CIK_INTSRC_DEQUEUE_COMPLETE 0xC6
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - lists.freedesktop.org
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx
> Archives. Using amd-gfx: To post a message to all the list members, sen=
d
> email ...
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20


--PfXR0o4XQMOIAAenHiphpTGbmn1Qnj889--

--WjkB6XvNKsHICSr79qWuVlVRMqiBuUmSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6nYqAAoJEP4bvbfZuWjb06AP/35zumC7VUpOXCChuEHvJsdS
mQGyjopXncCcW02hf5z/boV/HBfiJboxa/IjtOTC8MBhhtGhpeiowZHJdEwv4+2l
bk1JdgnzJj28sLWrG1zm0oQaMhaEsBdDAMB8WgLvscJBw2f+A76jq4vnGW+jQRzb
QTt7PI8lAj5M37kxuwpNqLyhLdd4tJTZog99yB5ncuXGRKXk2sNmDHjamGH6/kKN
nkqGo25YKQjrmqp4Tj0GQOpLPFOJB4fLn9XjDtM2kbuLOSGZg7YRJBvlDVMIJtph
LbHQXkvu1QD04V96wg3KNdeEsPahzxmj8CPxIGXDhsw6sPMEE9YfFEQ3uLgiEN0k
DaJ6hWu9WizH/7F+Pa1oUj4KQAtiCf+8E36rf/OeNrjM7Hxfysp2LmBHpUDYNG/i
ZMNgmLXCQFuxd7vvp2Lva437DEuGfGkDcVpW1Ok8GPmefmvKNAiAgZ6F2n5TZf1A
qHRgtkMezn7c8Ip8XgVyglZhfKP0gWR2OEY4MRS4no8Xmlu+hVp311GXxffejh4r
x3gECo9M0hl8MWS1zQns33DxtKnibgocEq12eGy9v9EXc0uhKtOiQ9AVGz570Usq
C4/KZNGgQkO2xOvzHJwdP4sRoeNqZ0K2ePZr68P4Ey/lSxsrtZBMr+etv7bF2vcb
G6NcfZ5hs0DWupsYNa1e
=GQYw
-----END PGP SIGNATURE-----

--WjkB6XvNKsHICSr79qWuVlVRMqiBuUmSu--

--===============2120577582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2120577582==--

From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma3: drop unused functions
Date: Fri, 16 Sep 2016 18:28:03 +1000
Message-ID: <d51682dc-90f4-835c-2468-34cc33ca86ee@folklore1984.net>
References: <1473971453-12470-1-git-send-email-alexander.deucher@amd.com>
 <a58092fe-b0fa-24d0-04ac-c35250d9ae12@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0121837088=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a58092fe-b0fa-24d0-04ac-c35250d9ae12-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0121837088==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HNpIuaNPHeuV41rn9pDMQITFihVEpopJV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HNpIuaNPHeuV41rn9pDMQITFihVEpopJV
Content-Type: multipart/mixed; boundary="64XqB4PJc7bRfquOKGSTbFntUSqCLvpft";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <d51682dc-90f4-835c-2468-34cc33ca86ee-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma3: drop unused functions
References: <1473971453-12470-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
 <a58092fe-b0fa-24d0-04ac-c35250d9ae12-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <a58092fe-b0fa-24d0-04ac-c35250d9ae12-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--64XqB4PJc7bRfquOKGSTbFntUSqCLvpft
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/16/2016 05:35 PM, Christian K=C3=B6nig wrote:
> Am 15.09.2016 um 22:30 schrieb Alex Deucher:
>> These are not used yet.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

>=20
>> ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 25 ------------------------=
-
>>   1 file changed, 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index bee4978..cabb9fe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -499,31 +499,6 @@ static void sdma_v3_0_ring_emit_fence(struct
>> amdgpu_ring *ring, u64 addr, u64 se
>>       amdgpu_ring_write(ring, SDMA_PKT_TRAP_INT_CONTEXT_INT_CONTEXT(0)=
);
>>   }
>>   -unsigned init_cond_exec(struct amdgpu_ring *ring)
>> -{
>> -    unsigned ret;
>> -    amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_COND_EXE));
>> -    amdgpu_ring_write(ring, lower_32_bits(ring->cond_exe_gpu_addr));
>> -    amdgpu_ring_write(ring, upper_32_bits(ring->cond_exe_gpu_addr));
>> -    amdgpu_ring_write(ring, 1);
>> -    ret =3D ring->wptr;/* this is the offset we need patch later */
>> -    amdgpu_ring_write(ring, 0x55aa55aa);/* insert dummy here and
>> patch it later */
>> -    return ret;
>> -}
>> -
>> -void patch_cond_exec(struct amdgpu_ring *ring, unsigned offset)
>> -{
>> -    unsigned cur;
>> -    BUG_ON(ring->ring[offset] !=3D 0x55aa55aa);
>> -
>> -    cur =3D ring->wptr - 1;
>> -    if (likely(cur > offset))
>> -        ring->ring[offset] =3D cur - offset;
>> -    else
>> -        ring->ring[offset] =3D (ring->ring_size>>2) - offset + cur;
>> -}
>> -
>> -
>>   /**
>>    * sdma_v3_0_gfx_stop - stop the gfx async dma engines
>>    *
>=20
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--64XqB4PJc7bRfquOKGSTbFntUSqCLvpft--

--HNpIuaNPHeuV41rn9pDMQITFihVEpopJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX260TAAoJEP4bvbfZuWjbqw0P/iWC4EwabojMzGOARAl182tG
ZetlZNrRd+BSai+TG8GG/JBO3X0ijPQdEtP6TzeusGj7TgZulNvfoJbCQfnB5aLI
OqDlH24mTWQiGxWh1c+vuCPZg1v/NI7zyCaNxIHezSa+NC4hOP/xtgiPftoNcJ+d
1Id+5P7UhHlVwlTjdQ8hblsZzvmqCfMmjGy3LLg0RILmwZByLmx6E07q7zqnAQ9I
8tyLmRfTlfBpCzETfLaESlJ6OAH0uw9AFRRc1BVb6naWHo+GHNdfBu+0DYRNDeTh
Ov/2axFZiOKwIcjJY9z4qCqzr849gzR7BGZpG9VzspgGvCwyM7eF1DB9FJSvNM0X
oFSEFj8gxBqt5rUWF9HN0+7TZlcZwbN0ZyPivfOV3XNEz9hFZoncON89YHA03rAL
rk9UQxoWpm9Toc93rpm9YkmNjFDp4bPPnRqI16XSPk3jXqG7JXdZ5rO2rvJYkVMN
qHSr+Jp6wkwo4dgSvU0z7nxNQo/BLiwU6TkSNvxXX8rKBlJ2QmsLoOUwYBxeLQPi
z4trBJcYna3Jc/72Qms7AS3NZfQjevYsbaNZKk7XNZJgldrq6PDrbDa+od/H9t4e
g1jobqPG670bj+Ty7o8Yj0wsBcEcH+mIyuT7J2pZqoohNHMwXNUCO+uaDg2sMHfb
hNDspSE3/69lLuZgOhRh
=FTX1
-----END PGP SIGNATURE-----

--HNpIuaNPHeuV41rn9pDMQITFihVEpopJV--

--===============0121837088==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0121837088==--

From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] amdgpu: Use 'dev_err_ratelimited()' over 'dev_err()'
 on vm faults
Date: Mon, 7 Nov 2016 14:57:38 +1100
Message-ID: <5ca9807d-be75-e642-7734-5c827bbece9c@folklore1984.net>
References: <1478490470-27089-1-git-send-email-funfunctor@folklore1984.net>
 <1478490470-27089-3-git-send-email-funfunctor@folklore1984.net>
 <e46fd0b0-7d0d-d502-77e2-400c38cef605@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0267993566=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e46fd0b0-7d0d-d502-77e2-400c38cef605-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0267993566==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Po2RbCa4M4RA4TDiTfSN36xVp5XGT7p5s"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Po2RbCa4M4RA4TDiTfSN36xVp5XGT7p5s
Content-Type: multipart/mixed; boundary="mMfe8hctxcS9shCMaoM4woo3FE7gghkLx";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <5ca9807d-be75-e642-7734-5c827bbece9c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] amdgpu: Use 'dev_err_ratelimited()' over 'dev_err()'
 on vm faults
References: <1478490470-27089-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <1478490470-27089-3-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <e46fd0b0-7d0d-d502-77e2-400c38cef605-otUistvHUpPR7s880joybQ@public.gmane.org>
In-Reply-To: <e46fd0b0-7d0d-d502-77e2-400c38cef605-otUistvHUpPR7s880joybQ@public.gmane.org>

--mMfe8hctxcS9shCMaoM4woo3FE7gghkLx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/07/2016 02:55 PM, Michel D=C3=A4nzer wrote:
> On 07/11/16 12:47 PM, Edward O'Callaghan wrote:
>> It can be the case that upon GPU page faults we start trashing
>> the logs, and so let us ratelimit here to avoid that.
>>
>> Signed-off-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 8 ++++----
>>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 8 ++++----
>>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 8 ++++----
>>  3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v6_0.c
>> index b13c8aa..79af3f2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>> @@ -549,7 +549,7 @@ static void gmc_v6_0_vm_decode_fault(struct amdgpu=
_device *adev,
>>  	mc_id =3D REG_GET_FIELD(status, mmVM_CONTEXT1_PROTECTION_FAULT_STATU=
S,
>>  			      xxMEMORY_CLIENT_ID);
>> =20
>> -	dev_err(adev->dev, "VM fault (0x%02x, vmid %d) at page %u, %s from '=
%s' (0x%08x) (%d)\n",
>> +	dev_err_ratelimited(adev->dev, "VM fault (0x%02x, vmid %d) at page %=
u, %s from '%s' (0x%08x) (%d)\n",
>>  	       protections, vmid, addr,
>>  	       REG_GET_FIELD(status, mmVM_CONTEXT1_PROTECTION_FAULT_STATUS,
>>  			     xxMEMORY_CLIENT_RW) ?
>> @@ -1007,11 +1007,11 @@ static int gmc_v6_0_process_interrupt(struct a=
mdgpu_device *adev,
>>  	if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_FIRST)
>>  		gmc_v6_0_set_fault_enable_default(adev, false);
>> =20
>> -	dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>> +	dev_err_ratelimited(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>  		entry->src_id, entry->src_data);
>> -	dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",=

>> +	dev_err_ratelimited(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR =
  0x%08X\n",
>>  		addr);
>> -	dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",=

>> +	dev_err_ratelimited(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATU=
S 0x%08X\n",
>>  		status);
>>  	gmc_v6_0_vm_decode_fault(adev, status, addr, 0);
>=20
> If calling dev_err_ratelimited separately for each line means that some=

> lines corresponding to a single VM fault may or may not appear dependin=
g
> on the rate, it'd be better to use a single call per VM fault.
Ah ok, yes I was not 100% that was definitely the case - easy to fix, I
will resend a update to address it. Thanks, Ed.

>=20
>=20


--mMfe8hctxcS9shCMaoM4woo3FE7gghkLx--

--Po2RbCa4M4RA4TDiTfSN36xVp5XGT7p5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYH/uyAAoJEP4bvbfZuWjbIiwQAKDOIYcfpcGGm/W99kdWYZy4
+8gX08rcidGZjV5bSk4lxv2JFO5hCkRSWQbdCUdd54ySqNATrv4sHVPOZaZRsZ46
oiJrG2apAn0VLcD0BlQIAeNUxVdlwr0Q/oC+7hwDpg2lZjQ5RkKXcvaSk5GaMl19
nrHTbDGTpyIt0eXAvvT8glD3v5wRmQuqTz58kvFGnC4SQHRgkPFdokOaMBmv4wxp
Z0QXDLvz5rLEwYGQAC3NeJrC3n7lVAEvtCYZKSQ3/6Qw08EF5Ng4XI72+gz3wv3J
bhNsQuvDeOLK33JsiDKt1kSw/G3vOj8QSSORA9Ub+mI6GHQoJZ7C2njrPcX/+sqI
LzIu8TW+zxAquYGMT4xpLbtv2dZ5Z6mszGsQNXAtieoQrr1HmME+ERxqDn1AC87n
etYGxA+jJUyLwWGK+9VtKx2GGl82xTlQ6dM/fFLMPpx2nNv4RlqQ/11+bHdckZxq
uRxIzhzoH6x2YLcXe83AZInpXG+8raVBR9GDRfsW22zs4IDHZQIwBpItKxQpHUG+
KdK7yx2XnBwfbGhE/T97vGHPett+nCB8/zZqApMaN3Ev3i7BDI2+cyRrRKnLTAZ0
fCuG/G+DkA0+mphhnumY0NnIQXcSNuU6JZ4fr8nJ+y1d+DBNllf2aW947PR2ObJg
d8dfnAxHaXvC7jKdlKnh
=IIR6
-----END PGP SIGNATURE-----

--Po2RbCa4M4RA4TDiTfSN36xVp5XGT7p5s--

--===============0267993566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0267993566==--

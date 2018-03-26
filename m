From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Fix acquiring VM on large-BAR systems
Date: Sun, 25 Mar 2018 21:31:57 -0400
Message-ID: <694f9b1e-9c06-b4ed-6f08-2c2d1201ab3f@gmail.com>
References: <1521833436-31511-1-git-send-email-Felix.Kuehling@amd.com>
 <1521833436-31511-4-git-send-email-Felix.Kuehling@amd.com>
 <54d8848f-67ca-d611-48cc-d75699190be0@gmail.com>
 <6a4ec8be-6044-f5ac-8e2f-d8aa0fc024cc@amd.com>
 <14a96025-b9ee-93e3-69e0-ab0b2f364691@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1233338041=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <14a96025-b9ee-93e3-69e0-ab0b2f364691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1233338041==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rQLznU30CIZHmNarLUcrxtsoYx6MWY8Zr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rQLznU30CIZHmNarLUcrxtsoYx6MWY8Zr
Content-Type: multipart/mixed; boundary="FwvI1zV6ZeLd7RmnzQDAwBpyrrF2gRm4i";
 protected-headers="v1"
From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Message-ID: <694f9b1e-9c06-b4ed-6f08-2c2d1201ab3f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] drm/amdgpu: Fix acquiring VM on large-BAR systems
References: <1521833436-31511-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
 <1521833436-31511-4-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
 <54d8848f-67ca-d611-48cc-d75699190be0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <6a4ec8be-6044-f5ac-8e2f-d8aa0fc024cc-5C7GfCeVMHo@public.gmane.org>
 <14a96025-b9ee-93e3-69e0-ab0b2f364691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <14a96025-b9ee-93e3-69e0-ab0b2f364691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--FwvI1zV6ZeLd7RmnzQDAwBpyrrF2gRm4i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Am 2018-03-24 um 04:34 AM schrieb Christian K=C3=B6nig:
> Am 23.03.2018 um 20:53 schrieb Felix Kuehling:
>> On 2018-03-23 03:35 PM, Christian K=C3=B6nig wrote:
>>> Am 23.03.2018 um 20:30 schrieb Felix Kuehling:
>>>> On large-BAR systems the VM page tables for compute are accessed by
>>>> the CPU. Always allow CPU access to the page directory so that it ca=
n
>>>> be used later by the CPU when a VM is converted to a compute VM.
>>> NAK, that means we initial place the PD in the visible are for GFX
>>> which is not desired (not much of an issue for Vega/Raven, but bad fo=
r
>>> older generations).
>> I'm not setting AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED. Doesn't that me=
an
>> the buffer can be placed in invisible VRAM initially?
>
> The difference is the preference. When AMDGPU_GEM_CREATE_NO_CPU_ACCESS
> is set we try to place it initially in invisible VRAM.

Where is that done? I'm looking at amdgpu_ttm_placement_from_domain. It
only looks at AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED. It does not
consider the AMDGPU_GEM_CREATE_NO_CPU_ACCESS flag. So creating the BO
without AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED should have the intended
effect of placing the BO into invisible VRAM initially.

As far as I can tell, my patch does not change the initial placement. It
only allows the BO to be kmapped later.

>
> Since VM page directories have a low chance of being evicted it will
> just stick in visible VRAM when it was placed initially there.
>
>>> Better to clear the flag later on and set the
>>> AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED and then re-validate.
>> The AMDGPU_GEM_CREATE_NO_CPU_ACCESS seems to mean "this BO must never =
be
>> CPU mapped". Clearing that flag later kind of defeats the purpose of
>> making such a declaration at allocation time. If I know that the buffe=
r
>> may need CPU access at some point in the future, I figured I shouldn't=

>> set the flag in the first place.
>
> Correct, but that only counts for userspace because userspace can't
> modify the flags :)
>
> If I remember correctly we also enforce it in the mmap IOCTL that the
> flag isn't set, but that doesn't really matter for the kernel.
>
> At least the AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED flag is cleared and
> set all the time in the kernel (but not for VM page tables).

Right, I see it being set while pinning. But page tables don't usually
get pinned.

>
>> FWIW, I didn't see any example of the AMDGPU_GEM_CREATE_NO_CPU_ACCESS
>> flag ever being removed from an existing BO.
>
> Yeah, but that should be harmless as far as I can see.
>
> If you want to avoid the move of the page directory on large BAR
> systems when switching a VM from GFX to compute we can also initially
> create the BO in the system domain.
>
> Thinking about that a bit more that is probably a good idea anyway
> because it avoids using VRAM by just opening the device.

Sure, I'd do that as a separate change because it actually changes the
initial placement, whereas my patch did not (as far as I can tell).

Regards,
=C2=A0 Felix

>
> Regards,
> Christian.
>
>>
>> Regards,
>> =C2=A0=C2=A0 Felix
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>>>> ---
>>>> =C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +--
>>>> =C2=A0=C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 90ff79e..bc3557b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -2406,8 +2406,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,=

>>>> struct amdgpu_vm *vm,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vm->use_cpu_for_update)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=
=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D (AMDGPU_GEM_C=
REATE_NO_CPU_ACCESS |
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_CREATE_SHADOW);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D AMDGPU_GEM_CR=
EATE_SHADOW;
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D amdgpu_vm_bo_si=
ze(adev, adev->vm_manager.root_level);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_bo_create(adev, si=
ze, align, true,
>>>> AMDGPU_GEM_DOMAIN_VRAM,
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx




--FwvI1zV6ZeLd7RmnzQDAwBpyrrF2gRm4i--

--rQLznU30CIZHmNarLUcrxtsoYx6MWY8Zr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlq4TZUACgkQ1hkrDAUMk3aUZAEAo1T9HFBa2m2n1mVY/5ZLrxH3
TYKQC7Zl3nJXRzTkS3sBAJ4Wx6B2yScwJ5HkPhgLUDQj/IOq2SFAiJH1tcWa8TXk
=weNk
-----END PGP SIGNATURE-----

--rQLznU30CIZHmNarLUcrxtsoYx6MWY8Zr--

--===============1233338041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1233338041==--

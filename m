Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F62CD6E4C
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7447E10FA45;
	Fri, 29 May 2026 07:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="AVojkEPx";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3F3D10F2C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779979306; x=1780584106; i=natalie.vock@gmx.de;
 bh=6gjX6biNzQZKroGLjuwFkYkkjIbyGP5Qr7yML9nPeqE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AVojkEPxfitSOdPKMGsZoY9yEbmBVyx2upfTRn0nmL0SG3qJ9huLj2YayKYXjPX9
 EV6MVDF60fALwqNWVw0QtpZ3ZIdZJWiE77bvsx6riY/1ldi6kdIDhDyfOVONVpmQK
 BWx4iPpl0arAtxo+qRqaQLkxOh3JUjC9Blg4jjP99liIT/kG0VJVZWNcPEl6FGjMY
 M2HKs2Ifh/TbLglIIt0hI2NFqL4qMRyvXOJfAqKHiLPdIfpNTndgFF7UUTK02erSR
 gVvrLkBqPb1LzgnTPA7G80AuOPe0mdl4bCWH/+VMq+qcvv1hDqluQ0PRiqhEG2YhA
 5M5cNTuNvH+ENNHixA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N49lD-1xSaR10m4f-015Xjl; Thu, 28
 May 2026 16:41:46 +0200
Message-ID: <77267403-6b58-4d57-bd2b-911f7630de23@gmx.de>
Date: Thu, 28 May 2026 16:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Only set bo->moved when the BO was
 actually moved
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260527162918.9585-1-natalie.vock@gmx.de>
 <a23d40b2-8ae5-42f0-a0b9-a76875b13614@amd.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <a23d40b2-8ae5-42f0-a0b9-a76875b13614@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q3QpJeXYB8x5ZOhKIGVGI0JBsnGfJP2n2xBwJBDxaZFEeQLTQMt
 /k9Yv8y41kT2sHkYs/C7hJ4M3OVmCiVnzyTK7ajMx/obmFznwHR+7KUxtG7pYuZDBqiIdgn
 FdGmwo7anlHIg3olGJk7wlv1b5f904oIJFYPITf1NK3toHr8bRA2FB963x2tA1E8qYm2CJw
 KBgJcMsAjMgN4QysR71Tw==
UI-OutboundReport: notjunk:1;M01:P0:CJMssSJe+3g=;mEpiB5GtTpTi+akUe0IMuVtJqoI
 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
 O5FQa8lo9fWkFxPR7w7rq5oQshBBgOBM51HGseF
X-Mailman-Approved-At: Fri, 29 May 2026 07:44:33 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/28/26 09:04, Christian K=C3=B6nig wrote:
> On 5/27/26 18:29, Natalie Vock wrote:
>> The "moved" VM state is a bit unfortunately named, because BOs can end
>> up in this state without being physically moved. While we need to
>> invalidate every mapping when BOs are physically moved, in some other
>> cases like PRT binds/unbinds there is no need to refresh mappings excep=
t
>> those affected by the bind.
>>
>> Full invalidation of all BO mappings manifested as severe regressions i=
n
>> PRT bind performance, which this patch fixes. The offending patch is
>> 53f0235c0284 ("drm/amdgpu: restructure VM state machine v4") in the
>> amd-staging-drm-next tree, although it has not yet propagated anywhere
>> else.
>=20
> Thanks a lot for nailing this down, but that was actually one of the bug=
s I was trying to fix with this.
>=20
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
>> index beaf0aef6f474..969716b3e67e4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -214,11 +214,13 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm=
_bo_base *vm_bo)
>>    * amdgpu_vm_bo_moved - vm_bo is moved
>>    *
>>    * @vm_bo: vm_bo which is moved
>> + * @moved: true if the BO physically changed locations, i.e. all previ=
ous
>> + *         mappings are invalid
>>    *
>>    * State for vm_bo objects meaning the underlying BO was moved but th=
e new
>>    * location not yet reflected in the page tables.
>>    */
>> -static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>> +static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo, bool m=
oved)
>=20
> Just move setting the moved flag out of this function.
>=20
>>   {
>>   	struct amdgpu_vm_bo_status *lists;
>>   	struct amdgpu_bo *bo =3D vm_bo->bo;
>> @@ -232,7 +234,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_=
base *vm_bo)
>>   		vm_bo->moved =3D false;
>>   		list_move(&vm_bo->vm_status, &lists->idle);
>>   	} else {
>> -		vm_bo->moved =3D true;amdgpu_vm_validate
>> +		if (moved)
>> +			vm_bo->moved =3D true;
>>   		list_move(&vm_bo->vm_status, &lists->moved);
>>   	}
>>   	amdgpu_vm_bo_unlock_lists(vm_bo);
>> @@ -425,7 +428,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_bas=
e *base,
>>   	 */
>>   	if (bo->preferred_domains &
>>   	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
>> -		amdgpu_vm_bo_moved(base);
>> +		amdgpu_vm_bo_moved(base, true);
>>   	else
>>   		amdgpu_vm_bo_evicted(base);
>>   }
>> @@ -597,7 +600,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>>   			return r;
>>  =20
>>   		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
>> -		amdgpu_vm_bo_moved(bo_base);
>> +		amdgpu_vm_bo_moved(bo_base, false);
>=20
> That one and all other in amdgpu_vm_validate() look questionable to me.
>=20
> When the buffer was validated (e.g. physically moved) the flag should al=
ready be set, but setting it again should be harmless in most cases.

Validation doesn't always imply a physical move, though, does it? For=20
example, you can run into a case where the buffer is marked evicted=20
because it's not in the preferred domains, but if there is no space in=20
the preferred domain and the buffer is currently resident in an allowed=20
domain, validation backs off and doesn't do anything.

I'm generally not the biggest fan of doing things twice for no reason,=20
and the justification for setting the "moved" flag sounds pretty weak.

IMO it's much clearer to simply have the "moved" flag set in the=20
callchain of amdgpu_bo_move_notify, i.e. precisely when it actually has=20
been moved, but not in other random places.

I'll send a v2 with the moved flag-setting outside amdgpu_vm_bo_moved=20
shortly.

Thanks,
Natalie

>=20
>>   	}
>>  =20
>>   	/*
>> @@ -614,7 +617,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>>   		if (r)
>>   			return r;
>>  =20
>> -		amdgpu_vm_bo_moved(bo_base);
>> +		amdgpu_vm_bo_moved(bo_base, false);
>>   	}
>>  =20
>>   	if (!ticket)
>> @@ -634,7 +637,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>>   		if (r)
>>   			return r;
>>  =20
>> -		amdgpu_vm_bo_moved(bo_base);
>> +		amdgpu_vm_bo_moved(bo_base, false);
>>  =20
>>   		/* It's a bit inefficient to always jump back to the start, but
>>   		 * we would need to re-structure the KFD for properly fixing
>> @@ -1782,7 +1785,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu=
_device *adev,
>>   		amdgpu_vm_prt_get(adev);
>>  =20
>>   	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>> -		amdgpu_vm_bo_moved(&bo_va->base);
>> +		amdgpu_vm_bo_moved(&bo_va->base, false);
>=20
> This is probably the one which really kills you.
>=20
> Thanks,
> Christian.
>=20
>>  =20
>>   	trace_amdgpu_vm_bo_map(bo_va, mapping);
>>   }
>> @@ -2091,7 +2094,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_dev=
ice *adev,
>>  =20
>>   		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>   		    !before->bo_va->base.moved)
>> -			amdgpu_vm_bo_moved(&before->bo_va->base);
>> +			amdgpu_vm_bo_moved(&before->bo_va->base, false);
>>   	} else {
>>   		kfree(before);
>>   	}
>> @@ -2106,7 +2109,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_dev=
ice *adev,
>>  =20
>>   		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>>   		    !after->bo_va->base.moved)
>> -			amdgpu_vm_bo_moved(&after->bo_va->base);
>> +			amdgpu_vm_bo_moved(&after->bo_va->base, false);
>>   	} else {
>>   		kfree(after);
>>   	}
>> @@ -2280,7 +2283,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo=
, bool evicted)
>>  =20
>>   		if (bo_base->moved)
>>   			continue;
>> -		amdgpu_vm_bo_moved(bo_base);
>> +		amdgpu_vm_bo_moved(bo_base, true);
>>   	}
>>   }
>>  =20
>=20


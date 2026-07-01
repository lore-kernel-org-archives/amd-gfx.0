Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FEDC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE87B10F201;
	Thu,  2 Jul 2026 08:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="HsCBzrTh";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB0D10E5A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782911585; x=1783516385; i=natalie.vock@gmx.de;
 bh=9oulftn68REp1oz05YQRUMe77OX0hp+JTLh5TbTT4rs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HsCBzrThhKA4HU7Ip25zljl2QHDyOmgMDHq4A7ohU+jAiGK1BI5jvy/vbnLMiEhA
 pV8NO3yUP4V0KPMlxagv0Pdi8Wfm9+dgqSkqZD0sIUvc7vJqwz6Tgh6mE6wa0aOFI
 LIZMfdhNC+jrpUGcWcnFn43sO362+HUYkW4gYhGWi4rkSXE4B2H7fK1TxZxTHmbb2
 9REVH8xWZTFJoXAMSGqQsr5Z2908QePfISQnKEGvdsvf3WnAzM8SViIDPcET9ioXC
 flBaSGWB0ILQcC/j7wih2OaTCrdTmnd/ZtZrzHEne2Z1ih6YXhx5DARtjoGVr7g5n
 yax3NRlWpuCNfLUMXw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1xS0wN1CMs-00oEy7; Wed, 01
 Jul 2026 15:13:05 +0200
Message-ID: <257de090-8c25-4158-9df3-42be3aef890c@gmx.de>
Date: Wed, 1 Jul 2026 15:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix VM status/vm_bo->moved locking
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260701113340.466177-1-natalie.vock@gmx.de>
 <ef3a15a5-ea21-4ec3-a1b9-2a6a51987e36@amd.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <ef3a15a5-ea21-4ec3-a1b9-2a6a51987e36@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tv3Nnm6rN5lDZ4J1MFKDDLFETUS++oVpHJmOT/zPyM/QHo6GMMQ
 TF0T6UFVdNzMVsmttrvlAeDFqMTl8UgAJ5/viSe8z6bwKsA/T3VeIwV/xJYCU5r6WBWyUU9
 70gfudenIngWnFx5GG848IG3CEilRiXJqgXVpv1dHtppEdWuaaUt1/4qrP7XrjtQA/K8x0f
 hyJuCWEYzEZnckgSRpG/g==
UI-OutboundReport: notjunk:1;M01:P0:8wl2PAjtPbI=;z8oH8Om11k3gYDmyPv3QGwadtgY
 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
X-Mailman-Approved-At: Thu, 02 Jul 2026 08:07:22 +0000
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

Hi,

On 7/1/26 14:26, Christian K=C3=B6nig wrote:
> On 7/1/26 13:33, Natalie Vock wrote:
>> We claimed vm_bo->moved was protected by the BO being reserved, but the=
n
>> accessed it in a bunch of places without a reservation to the BO anyway=
.
>=20
> Can you point out where? That clearly doesn't sound correct to me.

Right, actually on rechecking it's just one place, see below.

>=20
> We have some questionable uses for userptrs, but those should be irrelev=
ant.
>=20
>>
>> It's not sensible to protect this by BO reservation in any case - it's =
a
>> property relating to VM state, just like vm_status. Let's protect this
>> by vm->status_lock as well. We usually grab the lock at some point when
>> we access the field anyway, so it fits well with the current usage of
>> the field.
>=20
> That won't work. You can't hold the status lock while the moved flag can=
't be modified.

I know holding the status spinlock throughout the entire runtime of=20
amdgpu_vm_bo_update is not viable, and I'm not trying to do that here.=20
Is there another period where the moved flag absolutely can't be modified?

>=20
>> We also need to remove some unprotected accesses of the field when
>> removing a mapping. Checking for the field there was a microoptimizatio=
n
>> anyway.
>>
>> Lastly, and most critically, we also need to handle buffer
>> moves/invalidations racing with amdgpu_vm_bo_update. Otherwise we might
>> accidentally undo the invalidation without the PTs actually being
>> properly updated.
>=20
> That's not correct as far as I can see the moves/invalidations can perfe=
ctly happen in paralell and are handled before the next CS.

The race requires some setup:
1. Assume we're talking about a BO with its own resv, i.e. a=20
not-VM-always-valid buffer.
2. Assume the BO is already in the invalidated list.
3. Assume one thread is trying to evict the buffer and therefore holds=20
the reservation object.
4. Assume another thread is trying to submit a CS that does *not* have=20
this buffer in the BO list, that is, it is not reserved by the CS ioctl.

Now, imagine the submitting thread is currently in=20
amdgpu_vm_handle_moved, and ends up encountering that BO while iterating=
=20
through the invalidated list here:
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c#L1639.

dma_resv_trylock() fails, and the caller is not holding the reservation=20
lock. Still, as intended, we try updating the PTs and enter=20
amdgpu_vm_bo_update (while *not* holding the resv).

For one, vm_bo->moved is accessed here:
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c#L1345
and set here:
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c#L1396

AFAIU, both of these may race with something else.

Also, the evicting thread may finish calling amdgpu_bo_move_notify=20
before the thread running amdgpu_vm_bo_update reaches the=20
amdgpu_vm_bo_done here:
https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c#L1391

If that happens, then the BO is marked as idle again even though the=20
concurrent eviction had just invalidated the mappings. I'm like 98% sure=
=20
I've run into page faults on supposedly mapped addresses precisely due=20
to this. :)

Best,
Natalie

>=20
> Regards,
> Christian.
>=20
>>
>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>> FWIW, I'm not 100% positive on whether the Fixes tag is correct - I'm
>> fairly certain the VM update <-> invalidation race existed ever since
>> the driver's inception, but it may have been hidden in the initial
>> revision. I suspect backporting it all the way to wherever the race
>> started manifesting is roughly similarly painful, though.
>>
>> Also, this patchset is based on my previous one to rename the "moved" V=
M
>> state to "needs_update". I think it got reviewed and should've been
>> picked up, but I'm not sure I see it in amd-staging-drm-next?
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 108 +++++++++++++++++-------=
-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
>>   2 files changed, 75 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
>> index 32719f31b6c9e..3451dca7de194 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -214,11 +214,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm=
_bo_base *vm_bo)
>>    * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
>>    *
>>    * @vm_bo: vm_bo which is out of date
>> + * @moved: whether the vm_bo was moved
>>    *
>>    * State for vm_bo objects meaning the underlying BO had mapping chan=
ges (move, PRT bind/unbind)
>>    * but the new location is not yet reflected in the page tables.
>>    */
>> -static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
>> +static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo,=
 bool moved)
>>   {
>>   	struct amdgpu_vm_bo_status *lists;
>>   	struct amdgpu_bo *bo =3D vm_bo->bo;
>> @@ -232,11 +233,28 @@ static void amdgpu_vm_bo_needs_update(struct amdg=
pu_vm_bo_base *vm_bo)
>>   		vm_bo->moved =3D false;
>>   		list_move(&vm_bo->vm_status, &lists->idle);
>>   	} else {
>> +		if (moved)
>> +			vm_bo->moved =3D true;
>>   		list_move(&vm_bo->vm_status, &lists->needs_update);
>>   	}
>>   	amdgpu_vm_bo_unlock_lists(vm_bo);
>>   }
>>  =20
>> +/**
>> + * amdgpu_vm_bo_idle_locked - vm_bo is idle, already-locked version
>> + *
>> + * @vm_bo: vm_bo which is now idle
>> + *
>> + * State for vm_bo objects meaning we are done with the state machine =
and no
>> + * further action is necessary. Needs to supply a locked status list.
>> + */
>> +static void amdgpu_vm_bo_idle_locked(struct amdgpu_vm_bo_base *vm_bo,
>> +			      struct amdgpu_vm_bo_status *lists)
>> +{
>> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
>> +		vm_bo->moved =3D false;
>> +	list_move(&vm_bo->vm_status, &lists->idle);
>> +}
>>   /**
>>    * amdgpu_vm_bo_idle - vm_bo is idle
>>    *
>> @@ -250,9 +268,7 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_b=
ase *vm_bo)
>>   	struct amdgpu_vm_bo_status *lists;
>>  =20
>>   	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
>> -	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
>> -		vm_bo->moved =3D false;
>> -	list_move(&vm_bo->vm_status, &lists->idle);
>> +	amdgpu_vm_bo_idle_locked(vm_bo, lists);
>>   	amdgpu_vm_bo_unlock_lists(vm_bo);
>>   }
>>  =20
>> @@ -273,9 +289,9 @@ static void amdgpu_vm_bo_reset_state_machine(struct=
 amdgpu_vm *vm)
>>   	 */
>>   	amdgpu_vm_assert_locked(vm);
>>   	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
>> -		amdgpu_vm_bo_needs_update(vm_bo);
>> +		amdgpu_vm_bo_needs_update(vm_bo, false);
>>   	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_stat=
us)
>> -		amdgpu_vm_bo_needs_update(vm_bo);
>> +		amdgpu_vm_bo_needs_update(vm_bo, false);
>>  =20
>>   	spin_lock(&vm->individual_lock);
>>   	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status=
) {
>> @@ -435,7 +451,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_bas=
e *base,
>>   	 */
>>   	if (bo->preferred_domains &
>>   	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
>> -		amdgpu_vm_bo_needs_update(base);
>> +		amdgpu_vm_bo_needs_update(base, false);
>>   	else
>>   		amdgpu_vm_bo_evicted(base);
>>   }
>> @@ -607,8 +623,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>>   			return r;
>>  =20
>>   		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
>> -		bo_base->moved =3D true;
>> -		amdgpu_vm_bo_needs_update(bo_base);
>> +		amdgpu_vm_bo_needs_update(bo_base, true);
>>   	}
>>  =20
>>   	/*
>> @@ -625,8 +640,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>>   		if (r)
>>   			return r;
>>  =20
>> -		bo_base->moved =3D true;
>> -		amdgpu_vm_bo_needs_update(bo_base);
>> +		amdgpu_vm_bo_needs_update(bo_base, true);
>>   	}
>>  =20
>>   	if (!ticket)
>> @@ -646,8 +660,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
>>   		if (r)
>>   			return r;
>>  =20
>> -		bo_base->moved =3D true;
>> -		amdgpu_vm_bo_needs_update(bo_base);
>> +		amdgpu_vm_bo_needs_update(bo_base, true);
>>  =20
>>   		/* It's a bit inefficient to always jump back to the start, but
>>   		 * we would need to re-structure the KFD for properly fixing
>> @@ -1266,16 +1279,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *a=
dev, struct amdgpu_bo_va *bo_va,
>>   	struct amdgpu_bo *bo =3D bo_va->base.bo;
>>   	struct amdgpu_vm *vm =3D bo_va->base.vm;
>>   	struct amdgpu_bo_va_mapping *mapping;
>> +	struct amdgpu_vm_bo_status *lists;
>>   	struct dma_fence **last_update;
>>   	dma_addr_t *pages_addr =3D NULL;
>>   	struct ttm_resource *mem;
>>   	struct amdgpu_sync sync;
>>   	bool flush_tlb =3D clear;
>> +	bool uncached, moved;
>>   	uint64_t vram_base;
>>   	uint64_t flags;
>> -	bool uncached;
>>   	int r;
>>  =20
>> +	/* Everything we access in here is protected by the VM PD lock. */
>> +	amdgpu_vm_assert_locked(vm);
>> +
>> +	lists =3D amdgpu_vm_bo_lock_lists(&bo_va->base);
>> +	/*
>> +	 * We can't hold the spinlock for the entire VM update, so temporaril=
y remove
>> +	 * the BO from the state machine entirely. This does not prevent all =
types of
>> +	 * races: We might not hold the BO's resv here, so TTM is free to mov=
e the buffer
>> +	 * and thereby invalidate it. However, it allows us to detect if we r=
aced with
>> +	 * something that invalidated the BO again and handle that appropriat=
ely below.
>> +	 */
>> +	list_del_init(&bo_va->base.vm_status);
>> +
>> +	/*
>> +	 * The moved flag is also protected by the status lock. It's fine if =
some buffer
>> +	 * update changes bo_va->base.moved while we're updating the PTs afte=
r unlocking
>> +	 * the status lock, since that also invalidates the BO's VM status ag=
ain.
>> +	 */
>> +	moved =3D bo_va->base.moved;
>> +	amdgpu_vm_bo_unlock_lists(&bo_va->base);
>> +
>>   	amdgpu_sync_create(&sync);
>>   	if (clear) {
>>   		mem =3D NULL;
>> @@ -1343,7 +1378,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v, struct amdgpu_bo_va *bo_va,
>>   	else
>>   		last_update =3D &bo_va->last_pt_update;
>>  =20
>> -	if (!clear && bo_va->base.moved) {
>> +	if (!clear && moved) {
>>   		flush_tlb =3D true;
>>   		list_splice_init(&bo_va->valids, &bo_va->invalids);
>>  =20
>> @@ -1389,20 +1424,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *a=
dev, struct amdgpu_bo_va *bo_va,
>>   		else
>>   			amdgpu_vm_bo_idle(&bo_va->base);
>>   	} else {
>> -		amdgpu_vm_bo_idle(&bo_va->base);
>> +		lists =3D amdgpu_vm_bo_lock_lists(&bo_va->base);
>> +		/*
>> +		 * Now that we're holding the lock again, check if the
>> +		 * buffer got invalidated while we weren't looking.
>> +		 * We initialized vm_status to an empty list head above,
>> +		 * if that's still the case we can safely mark the BO as
>> +		 * done.
>> +		 *
>> +		 * Note: We only need to do this for BOs that are not
>> +		 * VM-always-valid, because we hold the VM's reservation
>> +		 * which by definition reserves all VM-always-valid BOs.
>> +		 */
>> +		if (list_empty(&bo_va->base.vm_status))
>> +			amdgpu_vm_bo_idle_locked(&bo_va->base, lists);
>> +		amdgpu_vm_bo_unlock_lists(&bo_va->base);
>>   	}
>>  =20
>>   	list_splice_init(&bo_va->invalids, &bo_va->valids);
>>   	bo_va->cleared =3D clear;
>> -	bo_va->base.moved =3D false;
>>  =20
>>   	if (trace_amdgpu_vm_bo_mapping_enabled()) {
>>   		list_for_each_entry(mapping, &bo_va->valids, list)
>>   			trace_amdgpu_vm_bo_mapping(mapping);
>>   	}
>>  =20
>> +	amdgpu_sync_free(&sync);
>> +	return 0;
>> +
>>   error_free:
>>   	amdgpu_sync_free(&sync);
>> +	if (r)
>> +		amdgpu_vm_bo_needs_update(&bo_va->base, false);
>>   	return r;
>>   }
>>  =20
>> @@ -1779,7 +1832,6 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu=
_device *adev,
>>   				    struct amdgpu_bo_va_mapping *mapping)
>>   {
>>   	struct amdgpu_vm *vm =3D bo_va->base.vm;
>> -	struct amdgpu_bo *bo =3D bo_va->base.bo;
>>  =20
>>   	mapping->bo_va =3D bo_va;
>>   	list_add(&mapping->list, &bo_va->invalids);
>> @@ -1788,8 +1840,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu=
_device *adev,
>>   	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>>   		amdgpu_vm_prt_get(adev);
>>  =20
>> -	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>> -		amdgpu_vm_bo_needs_update(&bo_va->base);
>> +	amdgpu_vm_bo_needs_update(&bo_va->base, false);
>>  =20
>>   	trace_amdgpu_vm_bo_map(bo_va, mapping);
>>   }
>> @@ -2090,30 +2141,22 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_d=
evice *adev,
>>  =20
>>   	/* Insert partial mapping before the range */
>>   	if (!list_empty(&before->list)) {
>> -		struct amdgpu_bo *bo =3D before->bo_va->base.bo;
>> -
>>   		amdgpu_vm_it_insert(before, &vm->va);
>>   		if (before->flags & AMDGPU_VM_PAGE_PRT)
>>   			amdgpu_vm_prt_get(adev);
>>  =20
>> -		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>> -		    !before->bo_va->base.moved)
>> -			amdgpu_vm_bo_needs_update(&before->bo_va->base);
>> +		amdgpu_vm_bo_needs_update(&before->bo_va->base, false);
>>   	} else {
>>   		kfree(before);
>>   	}
>>  =20
>>   	/* Insert partial mapping after the range */
>>   	if (!list_empty(&after->list)) {
>> -		struct amdgpu_bo *bo =3D after->bo_va->base.bo;
>> -
>>   		amdgpu_vm_it_insert(after, &vm->va);
>>   		if (after->flags & AMDGPU_VM_PAGE_PRT)
>>   			amdgpu_vm_prt_get(adev);
>>  =20
>> -		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
>> -		    !after->bo_va->base.moved)
>> -			amdgpu_vm_bo_needs_update(&after->bo_va->base);
>> +		amdgpu_vm_bo_needs_update(&after->bo_va->base, false);
>>   	} else {
>>   		kfree(after);
>>   	}
>> @@ -2285,10 +2328,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *b=
o, bool evicted)
>>   			continue;
>>   		}
>>  =20
>> -		if (bo_base->moved)
>> -			continue;
>> -		bo_base->moved =3D true;
>> -		amdgpu_vm_bo_needs_update(bo_base);
>> +		amdgpu_vm_bo_needs_update(bo_base, true);
>>   	}
>>   }
>>  =20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
>> index c1bd4d35831e0..0acd889568a38 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -212,8 +212,7 @@ struct amdgpu_vm_bo_base {
>>   	 * protected by vm BO being reserved */
>>   	bool				shared;
>>  =20
>> -	/* if the BO was moved and all mappings are invalid
>> -	 * protected by the BO being reserved */
>> +	/* protected by the vm's status lock */
>>   	bool				moved;
>>   };
>>  =20
>=20


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933B606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMpOcIvp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594A310E224;
	Thu, 19 Nov 2026 09:26:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C7210E224
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 09:26:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B81F404DC;
 Thu, 19 Nov 2026 09:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8731F000C4;
 Thu, 19 Nov 2026 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795080392;
 bh=w8ubLZzlLuqo0Y87RIxtyV1YA7LMKZ3aJRLk6ED73FM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=KMpOcIvpPv0AgA8++V6U/d4HRlXO48FqALy25cfquVAWU0g0FArfaVnADPhEL/suQ
 YBSphN/5W9miW+iZWXrcCK5ZiZ9+b97jjQsIRvXMOtei6AIoFs4n81z5eIDbiUoQ1c
 kmmIlPFiXW/zflpZ871zq7zm5/HkoVSZc6Ua2VXjFTBITPPRXj3qkqHdic8xY4T0Lp
 cpZ7Cl71XNrxNTFvcVU9LzVoPFhGd6Hjf6EoaZMlSbg0j68RD4FMl2m0gWzLCKfUW3
 K8JMSihmLd4p1yseIegOEf2oZJ2fDabW/P2aHwj7Eg7MQA/WeaSUrMKfoFw7tE2pvg
 ePB7DZcW5vLFA==
Message-ID: <sashiko-outbox-222831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [v2 1/3] drm/amdkfd: leave the devices a process has no VM on
 out of debugging
To: "Jesse Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
References: <20261119090557.3494649-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:26:31 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdkfd: debug VMID hijack on non-active device in
  pm_map_process_v9()
- [Medium] drm/amdkfd: stale CWSR TMA debug flag in
  kfd_process_device_init_cwsr_dgpu()
--

commit 53d7a0d14fffa554af576ebf0d12a4cd46c01696
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/amdkfd: leave the devices a process has no VM on out of debugging

This commit activates and runs debug operations only on devices where the
target process has acquired a VM, tracking per-device activation in
pdd->debug_active.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_debug.c
> index 71b34a57c2cc2..d5699c2e1f7fe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c

[ ... ]

> @@ -626,12 +631,9 @@ void kfd_dbg_trap_deactivate(struct kfd_process *tar=
get, bool unwind, int unwind
>  	for (i =3D 0; i < target->n_pdds; i++) {
>  		struct kfd_process_device *pdd =3D target->pdds[i];
> =20
> -		/* If this is an unwind, and we have unwound the required
> -		 * enable calls on the pdd list, we need to stop now
> -		 * otherwise we may mess up another debugger session.
> -		 */
> -		if (unwind && i =3D=3D unwind_count)
> -			break;
> +		if (!pdd->debug_active)
> +			continue;
> +		pdd->debug_active =3D false;
> =20
>  		kfd_process_set_trap_debug_flag(&pdd->qpd, false);

[Severity: Medium]
Can this leave the CWSR TMA debug flag permanently enabled on a device
where pdd->debug_active is false?

When a process acquires a VM on a device, kfd_process_device_init_vm() ->
kfd_process_device_init_cwsr_dgpu() sets the TMA flag from the
process-wide debug_trap_enabled flag rather than pdd->debug_active:

drivers/gpu/drm/amd/amdkfd/kfd_process.c:kfd_process_device_init_cwsr_dgpu(=
) {
    ...
	kfd_process_set_trap_debug_flag(&pdd->qpd,
					pdd->process->debug_trap_enabled);
    ...
}

If a debugged process acquires a VM on an additional device after
kfd_dbg_trap_activate() has already run, pdd->debug_active remains false
on that device while the TMA debug flag is set to true, and
kfd_dbg_trap_deactivate() will now skip clearing it on detach.  The same
happens if a debugger attaches before runtime enable, the process acquires
a VM, and either the debugger detaches before runtime enable or
kfd_dbg_trap_activate() fails before reaching that device.

Should kfd_process_device_init_cwsr_dgpu() pass pdd->debug_active instead
of pdd->process->debug_trap_enabled?

[ ... ]

> @@ -727,6 +729,9 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>  	for (i =3D 0; i < target->n_pdds; i++) {
>  		struct kfd_process_device *pdd =3D target->pdds[i];
> =20
> +		if (!pdd->drm_priv)
> +			continue;
> +
>  		if (!kfd_dbg_is_per_vmid_supported(pdd->dev)) {
>  			r =3D reserve_debug_trap_vmid(pdd->dev->dqm, &pdd->qpd);
> =20
> @@ -739,6 +744,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>  			}
>  		}
> =20
> +		pdd->debug_active =3D true;

[Severity: High]
If a debugged process later acquires a VM and creates a queue on a
non-per-VMID device that was skipped here, can pm_map_process_v9() hijack
another process's reserved trap_debug_vmid on that device?

drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c:pm_map_process_v9() {
    ...
	if (kfd->dqm->trap_debug_vmid && pdd->process->debug_trap_enabled &&
			pdd->process->runtime_info.runtime_state =3D=3D DEBUG_RUNTIME_STATE_ENAB=
LED) {
		packet->bitfields2.debug_vmid =3D kfd->dqm->trap_debug_vmid;
		packet->bitfields2.new_debug =3D 1;
	}
    ...
}

When process A is debugged only on a dGPU (so A has debug_trap_enabled
and runtime_state =3D=3D DEBUG_RUNTIME_STATE_ENABLED, but pdd->debug_active=
 is
false on the iGPU) and process B reserves kfd->dqm->trap_debug_vmid on
the iGPU, process A creating a queue on the iGPU will map its process
context with new_debug =3D 1 and process B's debug_vmid.

In addition, pm_map_process_aldebaran(), create_queue_cpsch(), and
add_queue_mes() still check process->debug_trap_enabled instead of
pdd->debug_active, applying single_memops, is_dbg_wa, and
skip_process_ctx_clear to devices where debugging was not activated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119090557.3494=
649-1-Jesse.Zhang@amd.com?part=3D1

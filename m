Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2A606A330
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ierADvFJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F15112593;
	Fri, 13 Nov 2026 13:44:30 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496D310E555
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=FSUE+iC1wYEqvNm0uRZvPUTBe+z6w6Li8F2zjI8An/o=; t=1794493705; x=2109853705; 
 b=ierADvFJe5jeYz0yzhsGbYPrkCODN8omrW3uis/oPk/JoIJ0F5PaqacqaTvedrDOilmagfdftdH
 sR9mMCSP144h3yBjfGE/aqHNoO6hyW+3bLiB7LAyKm6Van2uznQnEstgcJuZUSuDnW+fdotPpx7od
 EizuyIdv78iuCKaMs7OvGela9nsN7nvi6ed/+cbwjbh+uQ+F8+YvUIpd7OYGr5lpWSVZ+bVZYVhmw
 gruBGEceLl0ZayA8wONH19f5H7DgnHnNrteADZGZTdFGS50fi1Np34HC/QztxVjtwxc+/hheNvPmk
 31FeVLLSjYThUjdSQWjs57caoD76tdurBe8Q==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRVmo-009aE2-UN; Thu, 12 Nov 2026 15:28:23 +0100
Date: Thu, 12 Nov 2026 11:28:19 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: clear the entire mapping when partially
 unmapping
Message-ID: <avXNA5-RkkY3BSvf@quatroqueijos.cascardo.eti.br>
References: <20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com>
 <sashiko-outbox-211287@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-211287@kernel.org>
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:44:24 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 02:15:41PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] drm/amdgpu: unmapped split endpoints in
>   amdgpu_vm_bo_clear_mappings()
> - [Low] drm/amdgpu: missing Fixes trailer in commit message
> --
> 
> commit 193793bc04d0356a7faf15b1ecf5a2a8fdd585ce
> Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> > drm/amdgpu: clear the entire mapping when partially unmapping
> >
> > When we partially clear a BO mapping, we only add the partially unmapped
> > region to the freed list. That will update the page table to clear that
> > mapping and leave the other endpoints mapped.
> >
> > However, we move the endpoints to the invalids list. When later closing
> > that BO, it will simply free the mapping and not clear the GPU page
> > tables.
> >
> > Drop the optimization and clear the entire mapping from the page tables.
> > As the endpoints are already in the invalids list, when that BO mapping
> > needs to be accessed, the page tables will be updated.
> >
> > Though that may clear, then write page table entries and even lead to
> > new page table allocations in certain situations, those would already
> > happen in the clear path.
> >
> > When measuring a given workload, it was noticed an extra allocation in
> > less than 10% of the cases, but no noticeable extra latency. In any
> > case, correctness is more important and this fixes the scenario
> > described.
> >
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> [Severity: Low]
> Since this fixes a page table leak on partial unmap, should it include a
> Fixes: tag for 387f49e54672 ("drm/amdgpu: fix clear_all and replace
> handling in the VM (v2)") or dc54d3d1744d ("drm/amdgpu: implement
> AMDGPU_VA_OP_CLEAR v2")?
> 

Okay, I have just addressed this in a different message.

> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index a99c2ef14be96..808b77083a5e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -2108,12 +2108,6 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
> >  	list_for_each_entry_safe(tmp, next, &removed, list) {
> >  		amdgpu_vm_it_remove(tmp, &vm->va);
> >  		list_del(&tmp->list);
> > -
> > -		if (tmp->start < saddr)
> > -		    tmp->start = saddr;
> > -		if (tmp->last > eaddr)
> > -		    tmp->last = eaddr;
> > -
> >  		tmp->bo_va = NULL;
> >  		list_add(&tmp->list, &vm->freed);
> >  		trace_amdgpu_vm_bo_unmap(NULL, tmp);
> 
> [Severity: High]
> Does queuing the unclamped mapping onto vm->freed leave the surviving
> before and after endpoints unmapped in the hardware page tables?
> 
> When amdgpu_vm_clear_freed() processes vm->freed, it now zeroes the PTEs
> for the entire original [tmp->start, tmp->last] range, wiping the PTEs of
> the surviving before and after sub-ranges.  However, two paths fail to
> re-populate those endpoints from bo_va->invalids:
> 
> 1. In amdgpu_vm_bo_clear_mappings(), amdgpu_vm_bo_needs_update() is only
> called when amdgpu_vm_is_bo_always_valid(vm, bo) is true:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_bo_clear_mappings() {
>     ...
> 	if (!list_empty(&before->list)) {
> 		struct amdgpu_bo *bo = before->bo_va->base.bo;
>     ...
> 		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
> 		    !before->bo_va->base.moved)
> 			amdgpu_vm_bo_needs_update(&before->bo_va->base);
> 	}
>     ...
> }
> 
> For normal individual BOs, before->bo_va and after->bo_va stay on
> vm->individual.idle instead of moving to vm->individual.needs_update, so
> amdgpu_vm_handle_moved() and amdgpu_userq_bo_validate() skip them and
> never restore their cleared PTEs unless the BO is explicitly passed in a
> legacy CS bo_list.
> 

Which is exactly what I would expect, so all seem fine here.

> 2. On immediate updates without AMDGPU_VM_DELAY_UPDATE,
> amdgpu_gem_va_update_vm() runs amdgpu_vm_clear_freed() and only calls
> amdgpu_vm_bo_update() on the ioctl target bo_va for MAP or REPLACE:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:amdgpu_gem_va_update_vm() {
>     ...
> 	r = amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
> 	if (r)
> 		goto error;
> 
> 	/* For MAP/REPLACE we also need to update the BO mappings. */
> 	if (operation == AMDGPU_VA_OP_MAP ||
> 	    operation == AMDGPU_VA_OP_REPLACE) {
> 		r = amdgpu_vm_bo_update(adev, bo_va, false);
> 		if (r)
> 			goto error;
> 	}
>     ...
> }
> 
> When userspace partially unmaps via AMDGPU_VA_OP_CLEAR (where bo_va is
> NULL) or splits a mapping belonging to another bo_va via
> AMDGPU_VA_OP_REPLACE, the surviving endpoints are cleared by
> amdgpu_vm_clear_freed() and never re-populated, causing GPU page faults
> when accessed (for instance on usermode queues synchronizing via
> vm_timeline_syncobj_out).
> 

Christian, do you want me to address this case here? It is non trivial as
we don't have the single bo_va as in the case of AMDGPU_VA_OP_MAP or
AMDGPU_VA_OP_REPLACE. Any tips on what to use to test this?

Thanks.
Cascardo.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com?part=1

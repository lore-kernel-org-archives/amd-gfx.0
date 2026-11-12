Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF2606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=rh2BCVdV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE8211257F;
	Fri, 13 Nov 2026 13:44:27 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE41810E53C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=oLpww1sIQ9cL9vUaBYgyHLXDOO3Awe16dZ11UJdYc3k=; t=1794493312; x=2109853312; 
 b=rh2BCVdVE9kbY4xtcJx1WcZqPDDM6DkKbI5RkcM3qk0BsGpKbUm9NA0cjD8KleXrHDL5He4nt7M
 zPcc5RLat1GvaZvtgb3Uh47UjViu7/aFIeXEzvR67LfEFYbbEzu5tlUW1sqSb000cmjCrKXoeb92T
 KcspKHx8N9zeZFt0ANvH8DsOUozc2FvC2/4ro/fWkSsVkMXmilbvEEhr1NyNXaNWBaycMwE1ge2Oa
 xeUjGJadmyenFazsvN+8PK4N/z4+vr+hEa8eG8rsRT2xSF8y4SSZdvOttPu/O9oqT6O1j7sDiOOqS
 gTEwfbYfyilfzC4jjsyj4vVF6Cu8T74Wt/UQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRVgU-009a6o-KK; Thu, 12 Nov 2026 15:21:51 +0100
Date: Thu, 12 Nov 2026 11:21:47 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: clear the entire mapping when partially
 unmapping
Message-ID: <avXLe9-R-yzQzGU_@quatroqueijos.cascardo.eti.br>
References: <20261111-amdgpu_partial_mappings_fix-v1-1-02c5dfa20889@igalia.com>
 <8333ede5-3833-4465-9eaf-ab9d1b75ca89@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8333ede5-3833-4465-9eaf-ab9d1b75ca89@amd.com>
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

On Thu, Nov 12, 2026 at 10:24:04AM +0100, Christian König wrote:
> On 11/11/26 19:28, Thadeu Lima de Souza Cascardo wrote:
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
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 

Sorry that I missed a Fixes line here, if possible to add it when applying,
I believe it is:

Fixes: 387f49e54672 ("drm/amdgpu: fix clear_all and replace handling in the VM (v2)")

Thanks.
Cascardo.

> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index a99c2ef14be9..808b77083a5e 100644
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
> > 
> > ---
> > base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> > change-id: 20261111-amdgpu_partial_mappings_fix-c48d729ef590
> > 
> > Best regards,
> > --  
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > 
> 

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F96606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=C2NfhXOW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7229F10E9FF;
	Wed, 11 Nov 2026 13:48:09 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9549010E9BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=VFC4TjO/0Ux3i8aDYEyxhljXY1da/eSLxem5Hy10bfw=; t=1794401080; 
 x=2109761080; b=C2NfhXOWqis3vzgSJE9+a+hX/vGps4tbA72T0IeDFWeI85+xlu5KY2UW9BI4P
 4h40vqHzpGgVeI23FGFyfdipF4sL6vcHFwj20RBm6hMPhMZ8QodmGhk2wh27wMXqKPN8mfr5UpY8N
 AvHuBEDu+mySSuZpJ37YRmNcX+SIkOU8eB/5zM18GzhClInRGDYioASc1oP96S6OUvm2OYFPQRwpX
 kDRNjb/w1uaiayU+yz5Sye8XdJ/chRxO8qgJKgUn6lNsJMHN/BOXylaLdN/TeVyqUu5ltEb8p/aKk
 8aQbgqX1HEJkx+6KET+/flXXEskYHYGxlotAhKfoDGtTvm5omA==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR7gs-008p4b-4H; Wed, 11 Nov 2026 13:44:38 +0100
Date: Wed, 11 Nov 2026 09:44:34 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: "Mu, Zihao" <Zihao.Mu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [RFC PATCH v2 3/6] drm/amdgpu: finalize partial VM range updates
 on error
Message-ID: <avRjMtxFHCm9IXlU@quatroqueijos.cascardo.eti.br>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BB2BE619E89D33B7A03E9E712@MW3PR12MB4572.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR12MB4572BB2BE619E89D33B7A03E9E712@MW3PR12MB4572.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:48:08 +0000
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

On Wed, Nov 11, 2026 at 11:55:51AM +0000, Mu, Zihao wrote:
> From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> A PTE walk can fail after earlier batches changed page tables or queued
> SDMA commands. Its current early exit bypasses the final commit, TLB
> handling and draining of the stack-local tlb_flush_waitlist.
> 
> Stop the range walk on failure, then finish the existing commit, TLB
> and page-table cleanup sequence. Preserve the first update error so
> that successful finalization cannot turn an incomplete mapping into
> success. Preparation failures keep their existing early exit.
> 
> The preceding internal-completion tracking keeps the latest submitted
> IB available to TLB finalization, including immediate updates and failed
> replacement-job allocations. Finalization does not rely on a caller
> output fence being present or updated.
> 
> [zmu: Adapt to the int-returning commit API and tracked completion.]
> Link: https://lore.kernel.org/amd-gfx/20260914-amdgpu_vm_fixes-v1-4-d6d835591e0f@igalia.com/
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Signed-off-by: Zihao Mu <zmu@amd.com>

If you apply this patch [1], you don't need to adjust for the int API, and
it makes both this and the next patch cleaner.

Is there any reason not to apply it?

I am sending another cleanup in response to one of the patches for
comments, if they look fine, I can send it properly.

Thanks.
Cascardo.

[1] https://lore.kernel.org/amd-gfx/20260924-amdgpu_vm_update_funcs_commit_void-v1-1-9ad7a8283920@igalia.com/

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 1e41f159ced..f76459f8312 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1179,7 +1179,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>  	struct amdgpu_vm_update_params params;
>  	struct amdgpu_res_cursor cursor;
> -	int r, idx;
> +	int r, commit_r, idx;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>  		return -ENODEV;
> @@ -1278,14 +1278,17 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		tmp = start + num_entries;
>  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
>  		if (r)
> -			goto error_free;
> +			break;
>  
>  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
>  		start = tmp;
>  	}
>  
> -	r = vm->update_funcs->commit(&params, fence);
> -	if (r)
> +	/* Finish partial work without hiding the original update error. */
> +	commit_r = vm->update_funcs->commit(&params, fence);
> +	if (!r)
> +		r = commit_r;
> +	if (commit_r)
>  		goto error_free;
>  
>  	if (params.needs_flush) {
> -- 
> 2.43.0
> 

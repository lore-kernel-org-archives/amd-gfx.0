Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78223606A326
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nz6tNWem
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E181510E14B;
	Tue, 10 Nov 2026 14:07:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F8110EF81
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 10:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=uXa4i3xL+C3KXA9TbDJjQ0HAP9I1aTzs5qeuaq9PqJE=; t=1794306596; x=2109666596; 
 b=nz6tNWemAdczVwJERTAo4iMsJd7vHrwc+sSM1cSxMa19SOXl1EnCvHtZ+SmG2sB8S7R+km63q8v
 f5tNXhggKEYgkBJ+8mnk+rDEd/aNdSynkmXlIkZz2A/Juv0Ky7kvbvGtXTPtcvIvslG/CjBZH1q2O
 xaec/1BJaSfjLuvtzBMptDymjfUxGA+Ieg4qgKlnrpIFlwtzMCOyx0jWA2H6UZse1G5d04Du/Rkwc
 GizSY8V1WPZDx6nyM2HCcN2Rl6c5Ib/WVKufjGyLrBWuHcRqrRb7O/6Z+37EKfKLRmFKZ1jHRWwKi
 qAI9fkd8A0FVH02XlRV8YjBkSq+0ONQWodUw==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xQj6w-0083xX-0w; Tue, 10 Nov 2026 11:29:54 +0100
Date: Tue, 10 Nov 2026 07:29:49 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Benjamin Cheng <benjamin.cheng@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
Message-ID: <avLyHUZ4NMWMQ5U7@quatroqueijos.cascardo.eti.br>
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
X-Mailman-Approved-At: Tue, 10 Nov 2026 14:07:42 +0000
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

On Fri, Nov 06, 2026 at 09:55:36AM +0100, Christian König wrote:
> On 11/5/26 22:00, Benjamin Cheng wrote:
> > In the happy path, the job gets freed when the job is submitted.
> > However, if amdgpu_vm_ptes_update failed, we don't submit the job, so we
> > would leak the job.
> 
> Yeah that was already brought up upstream as well, but that here is the wrong approach to fixing this.
> 
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> came up with a few patches on the public mailing list to tackle this as well.
> 
> Essentially we need to commit PTE updates before we allocate any new PT, background is not only that allocating PTs can fail but also that we need to drop the lock for this and that can make the PTEs we already constructed in the SDMA IB invalid.
> 
> I wanted to get that fixed for weeks but couldn't find time for it. Can you guys together look into that?
> 
> Thanks in advance,
> Christian.
> 

Hey, Christian.

I have been looking at this and trying to find out the best shape of the vm
hooks and other helpers we might want to introduce here.

But first I tried to work on a reproducer and I realized that we have two
situations:

1) In the case of DRM, the BO should be locked, so there should not be any
eviction of move, so the entries in the IB should still be valid.

2) In the case of SVM, there is the prange lock. Does it still protect the
range, and, then, would the entries be still valid?

Is this related to what you propose at [1], where you mention:

"
This allows to remove the buggy SVM range lock, but that's not part of
this patch set.
"

Please, let me know if I am missing something or am working with the wrong
assumptions.

Thanks.
Cascardo.

[1] https://lore.kernel.org/amd-gfx/20260930133315.12270-7-christian.koenig@amd.com/

> > 
> > Fixes: 009f401fb98b ("drm/amdgpu: move amdgpu_vm_bo_update() call into correct location")
> > Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 2ba33212d507..f6cb2b5854dd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1274,8 +1274,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> >  
> >  		tmp = start + num_entries;
> >  		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
> > -		if (r)
> > +		if (r) {
> > +			if (params.job)
> > +				amdgpu_job_free(params.job);
> >  			goto error_free;
> > +		}
> >  
> >  		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
> >  		start = tmp;
> 

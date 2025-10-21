Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00949CCD1AA
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Oct 2025 13:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7967E10E5EE;
	Tue, 21 Oct 2025 13:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PuAdGPmH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B0010E5E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Oct 2025 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J/sYQ4N/yQz8xmp36PgjDIgB3ZJ3Uz2ZMCb0viVVl04=; b=PuAdGPmHCjXbnAvK7zeWpzZRNF
 ur/V0Ie5V0WhDmrYS2SH9Ipi81+azbMZFsbQLdy9a4vps2t5FYjLEM2U54OcNngU3O79CuAVofG0i
 64cDYYfUDx9NPbuzxlUrGDcBVVNCmWE+q17MSjZuPPC2rjxxpj9f8KVmzxPRWJt7ipLLGYrSYCR71
 UNVkiGiPbYzr3WDlq8MeTot0WVM7kjhk2tsa+cYfXNa4v2nEMTOXyVJRvBO0Q2NPIzpXvQKn8l6lz
 havcQFMxyByf/ziN1crwC6A5wWpUfyG/8RIScVNHOxwmc1t8gZ8+sIDW085xBUSWa/Jl+MX4hruU/
 XPmRPU+Q==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vBC9Q-00CXMf-I7; Tue, 21 Oct 2025 15:11:44 +0200
Date: Tue, 21 Oct 2025 07:11:39 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
Message-ID: <6ho4qbupb5sslxvv3z5o54a7pxt32hilqe5t3liyaexgivjdwr@mh7jyhx3h7ul>
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-2-siqueira@igalia.com>
 <44ecb43a-5f6e-440e-9e16-f56ca697eed4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44ecb43a-5f6e-440e-9e16-f56ca697eed4@gmail.com>
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

On 10/21, Timur Kristóf wrote:
> 
> 
> On 10/20/25 21:38, Rodrigo Siqueira wrote:
> > Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Timur Kristóf <timur.kristof@gmail.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
> >   2 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 5ec5c3ff22bb..29de8dbe2917 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
> >    * @ring: amdgpu_ring structure holding ring information
> >    * @ndw: number of dwords to allocate in the ring buffer
> >    *
> > - * Allocate @ndw dwords in the ring buffer (all asics).
> > - * Returns 0 on success, error on failure.
> > + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
> > + * inspecting the code, you may encounter places where this function is invoked
> > + * like this: amdgpu_ring_alloc(ring, X + Y + Z), where X, Y, and Z are integer
> > + * numbers. The idea of using each integer addition instead of the final result
> > + * is to explicitly indicate each block of operation that will be inserted into
> > + * the ring.
> 
> To clarify this further, I recommend using the term "packet" instead of
> "block of operation".

I'll make this change for the V4 version.

Thanks Alex and Tímur.

> 
> > + *
> > + * Returns:
> > + * 0 on success, otherwise -ENOMEM if it tries to allocate more than the
> > + * maximum dword allowed for one submission.
> >    */
> >   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
> >   {
> > @@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
> >   		ring->funcs->begin_use(ring);
> >   }
> > -/** amdgpu_ring_insert_nop - insert NOP packets
> > +/**
> > + * amdgpu_ring_insert_nop - insert NOP packets
> >    *
> >    * @ring: amdgpu_ring structure holding ring information
> >    * @count: the number of NOP packets to insert
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 87b962df5460..e83589619a92 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
> >   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
> >   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
> >   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> > +
> > +/* Ensure the execution in case of preemption or reset */
> >   #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
> >   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
> 

-- 
Rodrigo Siqueira

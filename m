Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB94CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 22:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0560F10E29C;
	Wed, 20 Aug 2025 22:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fLQkR+LM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4926110E29C
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zjFUti2S9BFlVPqkCYMsB0mW+ihbK5uMlTJ7uXBpoJI=; b=fLQkR+LMkeRE6n4HjFxfeOugYc
 RuIxCIIQ4iJEsVwEyw6QpVbeG4u/qoemNfqMZ5F6P4UChmPNwiWxCzgBwZBNFMoK1ThyWLhR54aQT
 UeslbvvCfyXk0Icvk/Xz+t7snjj7T+bP+GNIdUoCNXScIe0hdCwjW5c9110U1JFxA/xWymfqLAmcT
 t6FEPMeyL1QsgRy7Ju2+F/YEKKkqRtLpwu6IUAcWdeeZG/6fV6D3L0hbTv3DLdfK/CRFDOYLcFtcX
 YDlHKG3zCVqiLirtpu766Nnnf4spdruPpIHF8RihY/1UmgmoQdu7e+vbGq4/TqJglv/H6r/u5rxr8
 +P7WmFYg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uorWS-00Gyhr-4e; Thu, 21 Aug 2025 00:43:12 +0200
Date: Wed, 20 Aug 2025 16:43:07 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 1/5] drm/amdgpu: Expand kernel-doc in amdgpu_ring
Message-ID: <cd5z4nkx45prhcuzs6oywmrygykntxu7zdkjmwdnseeqh7gacq@3kzhjajrouiy>
References: <20250816153315.1285182-1-siqueira@igalia.com>
 <20250816153315.1285182-2-siqueira@igalia.com>
 <3fe258d7-e172-4d4f-9fc5-1738a1bf3857@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fe258d7-e172-4d4f-9fc5-1738a1bf3857@amd.com>
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

On 08/18, Christian König wrote:
> On 16.08.25 17:31, Rodrigo Siqueira wrote:
> > Expand the kernel-doc about amdgpu_ring and add some tiny improvements.
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian König <christian.koenig@amd.com>
> > Cc: Timur Kristóf <timur.kristof@gmail.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 15 ++++++++++++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > index 6379bb25bf5c..78fd324c84e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> > @@ -75,8 +75,16 @@ unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
> >   * @ring: amdgpu_ring structure holding ring information
> >   * @ndw: number of dwords to allocate in the ring buffer
> >   *
> > - * Allocate @ndw dwords in the ring buffer (all asics).
> > - * Returns 0 on success, error on failure.
> > + * Allocate @ndw dwords in the ring buffer (it works in all ASICs). When
> > + * inspecting the code, you may encounter places where this function is called
> > + * amdgpu_ring_alloc(ring, X + Y + Z) where X, Y, and Z are integer numbers.
> > + * This is a way to show how many dwords operations will be inserted in the
> > + * ring. For example, if gfx_v9_0_wait_reg_mem(), amdgpu_ring_emit_reg_wait(),
> > + * amdgpu_ring_emit_wreg(), and amdgpu_ring_emit_fence() will be called, before
> > + * that you will see amdgpu_ring_alloc(ring, 7 + 7 + 5 + 8).
> 
> Well the rest of the patch is certainly useful, but that here made me chuckle. Isn't that obvious?

Hi,

Interesting point. Tbh, it wasn't obvious to me the first time I saw it,
and I had to ask about it in one of the patch reviews. Perhaps this was
not evident to me because I'm new to this part of the code. I think a
kernel-doc in this function with this explanation can be helpful to some
other people looking into the code base for the first time, and might
also reduce one extra question to the maintainers. However, if you think
this is not necessary, I can drop it in the V2.

> 
> > + *
> > + * Returns:
> > + * 0 on success, error on failure.
> 
> We should probably adjust the return value of the function from -ENOMEM to -EINVAL when the number of the requested DW exceeds the maximum and document that here.

Since this will change the function return, I'll address it in another
patch.

Thanks

> 
> Apart from that looks good to me.
> 
> Christian.
> 
> >   */
> >  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
> >  {
> > @@ -122,7 +130,8 @@ static void amdgpu_ring_alloc_reemit(struct amdgpu_ring *ring, unsigned int ndw)
> >  		ring->funcs->begin_use(ring);
> >  }
> >  
> > -/** amdgpu_ring_insert_nop - insert NOP packets
> > +/**
> > + * amdgpu_ring_insert_nop - insert NOP packets
> >   *
> >   * @ring: amdgpu_ring structure holding ring information
> >   * @count: the number of NOP packets to insert
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index 7670f5d82b9e..d27dbb3c109f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -62,6 +62,8 @@ enum amdgpu_ring_priority_level {
> >  #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
> >  #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
> >  #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> > +
> > +/* Ensure the execution in case of preemption or reset */
> >  #define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
> >  
> >  #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
> 

-- 
Rodrigo Siqueira

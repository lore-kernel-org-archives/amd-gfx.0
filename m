Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7188C369B2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A30110E644;
	Mon, 14 Apr 2025 19:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="D0SvvxqP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DB510E644
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kAGnXYA8Lcwhn15syt9CSxMbl8oCfV3Cq8skhr/s7yA=; b=D0SvvxqPM568SLBx83r66OKe9Y
 vZzj+cDTAcOaMKw553Ym3DYmDqc77BM3qWIEMHwQhql/UMrMV9oBYpAMOEH6lw0dmcdTsfBJUwqot
 /yJuUtJHZ+ota3nv1g54t0tmmX84YRqmwP9evu9/XSDqfj8FvsDYwBIK5weUQSlUJKxAL2baFlPmx
 6Oq8FtDKdqsko+9RMbRCB4rtjxHz2z53TGvIXoJwKAE+jQpWiSko9tnbZX8WRrtHci9yM1AGo05l5
 aMqKYdlC61cWlOI88IBT8wV7H3cw+HZTfYohkQsZsuddaCiKAD0JA5RVAfCU0NxW8WTMMgDh3aFA9
 iPot8Cvg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u4PuQ-00Gf9C-9V; Mon, 14 Apr 2025 21:55:58 +0200
Date: Mon, 14 Apr 2025 13:55:54 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 'Christian =?utf-8?Q?K=C3=B6nig'?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH] drm/amdgpu: Add documentation to some parts of the
 AMDGPU ring and wb
Message-ID: <4ikdjw23ronaaq2a6frfczbpckeuig62xesufsqwmmlk2hytol@qy7c26saspgo>
References: <20250412203757.3026858-1-siqueira@igalia.com>
 <3eb190e3-dbde-4776-8a98-bbc02edab048@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eb190e3-dbde-4776-8a98-bbc02edab048@amd.com>
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

On 04/14, Mario Limonciello wrote:
> On 4/12/2025 3:37 PM, Rodrigo Siqueira wrote:
> > Add some random documentation associated with the ring buffer
> > manipulations and writeback.
> > 
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 29 ++++++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 37 ++++++++++++++++++++++++
> >   2 files changed, 65 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 804d37703709..a8206ad210b4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -522,9 +522,36 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> >   struct amdgpu_wb {
> >   	struct amdgpu_bo	*wb_obj;
> > +
> > +	/**
> > +	 * @wb:
> > +	 *
> > +	 * Pointer to the first writeback slot. In terms of CPU address
> > +	 * this value can be access directly by using the offset as an
> 
> 'accessed' not 'access '
> 
> right?
> 
> > +	 * index. For the GPU address, it is necessary to use gpu_addr and
> > +	 * the offset.
> > +	 */
> >   	volatile uint32_t	*wb;
> > +
> > +	/**
> > +	 * @gpu_addr:
> > +	 *
> > +	 * Writeback base address in the GPU.
> > +	 */
> >   	uint64_t		gpu_addr;
> > -	u32			num_wb;	/* Number of wb slots actually reserved for amdgpu. */
> > +
> > +	/**
> > +	 * @num_wb:
> > +	 *
> > +	 * Number of writeback slots actually reserved for amdgpu.
> 
> I don't think you need the word actually
> 
> > +	 */
> > +	u32			num_wb;
> > +
> > +	/**
> > +	 * @used:
> > +	 *
> > +	 * Track the writeback slot already used.
> > +	 */
> >   	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
> >   	spinlock_t		lock;
> >   };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index ec4de8df34e7..82972978c546 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -241,6 +241,9 @@ struct amdgpu_ring_funcs {
> >   	bool (*is_guilty)(struct amdgpu_ring *ring);
> >   };
> > +/**
> > + * amdgpu_ring - Holds ring information
> > + */
> >   struct amdgpu_ring {
> >   	struct amdgpu_device		*adev;
> >   	const struct amdgpu_ring_funcs	*funcs;
> > @@ -255,10 +258,44 @@ struct amdgpu_ring {
> >   	u64			wptr;
> >   	u64			wptr_old;
> >   	unsigned		ring_size;
> > +
> > +	/**
> > +	 * @max_dw:
> > +	 *
> > +	 * Maximum number of DWord for ring allocation. This information is
> 
> DWords
> 
> > +	 * provided at the ring initialization time, and each IP block can
> > +	 * specify a specific value.
> > +	 */
> >   	unsigned		max_dw;
> > +
> > +	/**
> > +	 * @count_dw:
> > +	 *
> > +	 * Count DWords: this value starts with the maximum amount of DWords
> > +	 * supported by the ring. This value is updated based on the ring
> > +	 * manipulation.
> > +	 */
> >   	int			count_dw;
> >   	uint64_t		gpu_addr;
> > +
> > +	/**
> > +	 * @ptr_mask:
> > +	 *
> > +	 * Some IPs provide support for 64-bit pointers and others for 32-bit
> > +	 * only; this behavior is component-specific and defined by the field
> > +	 * support_64bit_ptr. If the IP block supports 64-bits, the mask
> > +	 * 0xffffffffffffffff is set; otherwise, this value assumes buf_mask.
> > +	 * Notice that this field is used to keep wptr under a valid range.
> > +	 */
> >   	uint64_t		ptr_mask;
> > +
> > +	/**
> > +	 * @buf_mask:
> > +	 *
> > +	 * Buffer mask is a value used to keep wptr count under its
> > +	 * thresholding. Buffer mask initialized during the ring buffer
> > +	 * initialization time, and it is defined as (ring_size / 4) -1.
> > +	 */
> >   	uint32_t		buf_mask;
> >   	u32			idx;
> >   	u32			xcc_id;
>

Thanks Mario, I'll send a V2 with your suggestions.

-- 
Rodrigo Siqueira

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D0C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B0510E110;
	Tue, 22 Apr 2025 13:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WjIwsUVm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4F010E110
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZFL2Y5hpWKwUbW7MY57pWfOhg51Zg05LJCObQSenl34=; b=WjIwsUVmNTW4gOlH+hvRZx8U5M
 NFoPKg2xAdois0NviY9Gc90fsG0H9r76gm9cBSktku0xco9SDqiREY123ffxeEinmaucteJ4u0/r4
 buXvmQrIUHzObv10grAZjPvu7GQ+JOghN+zvUL+0tmSBFMruMeXri1/gY+NEWeakrtbByhhOCpL9t
 F8i5GNjsUcSiHJcFUjHU8LTHgoqT2YTlssH/tu8RWhgyNm4iFIp8c4kxLZ1PYr0VZ1dYrz/S/ZOZC
 bSd1OGx8ohnnF42MFfEZdEBEokCQcEinvGKlawe/Ttg9UqS27yIn8rP1OuN3KMgzJTI5otFsgQDsP
 jOVURZ4Q==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u7EA7-006StP-8z; Tue, 22 Apr 2025 15:59:47 +0200
Date: Tue, 22 Apr 2025 07:59:41 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] drm/amdgpu: Add documentation to some parts of the
 AMDGPU ring and wb
Message-ID: <p5o5jovbtbilyb32skmtp7a53o2fylyhk6x5onb2zsd6kgwqrl@usvdp4fzuul3>
References: <20250421222427.392362-1-siqueira@igalia.com>
 <CADnq5_NUzggmAmf3nSpOp0r3gnSLWiDM0rc6Cy2Y5yXFvkSXuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NUzggmAmf3nSpOp0r3gnSLWiDM0rc6Cy2Y5yXFvkSXuw@mail.gmail.com>
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

On 04/22, Alex Deucher wrote:
> On Mon, Apr 21, 2025 at 6:24 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > Add some random documentation associated with the ring buffer
> > manipulations and writeback.
> 
> I think this will result in documentation warnings if not all of the
> elements in the structure are documented?  If so, maybe it would be

This warning will likely be triggered only per struct, right? For the
case of the struct amdgpu_wb I can try to complete all the missing
fields for the next version. Regarding the writeback struct, I'm only
familiar with the display writeback where DCN writes the same data from
scanout in a memory buffer (at a scanout time). Does this writeback
behave similarly to the one from DCN?

> better to make then as regular comments rather than kerneldoc.
> 
> Alex
> 
> >
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 28 +++++++++++++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 37 ++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index cc26cf1bd843..6d2ae8d027e5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -522,9 +522,35 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> >
> >  struct amdgpu_wb {
> >         struct amdgpu_bo        *wb_obj;
> > +
> > +       /**
> > +        * @wb:
> > +        *
> > +        * Pointer to the first writeback slot. In terms of CPU address
> > +        * this value can be accessed directly by using the offset as an index.
> > +        * For the GPU address, it is necessary to use gpu_addr and the offset.
> > +        */
> >         volatile uint32_t       *wb;
> > +
> > +       /**
> > +        * @gpu_addr:
> > +        *
> > +        * Writeback base address in the GPU.
> > +        */
> >         uint64_t                gpu_addr;
> > -       u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
> > +
> > +       /**
> > +        * @num_wb:
> > +        *
> > +        * Number of writeback slots reserved for amdgpu.
> > +        */
> > +       u32                     num_wb;
> > +
> > +       /**
> > +        * @used:
> > +        *
> > +        * Track the writeback slot already used.
> > +        */
> >         unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
> >         spinlock_t              lock;
> >  };
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index ec4de8df34e7..20805dacd66c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -241,6 +241,9 @@ struct amdgpu_ring_funcs {
> >         bool (*is_guilty)(struct amdgpu_ring *ring);
> >  };
> >
> > +/**
> > + * amdgpu_ring - Holds ring information
> > + */
> >  struct amdgpu_ring {
> >         struct amdgpu_device            *adev;
> >         const struct amdgpu_ring_funcs  *funcs;
> > @@ -255,10 +258,44 @@ struct amdgpu_ring {
> >         u64                     wptr;
> >         u64                     wptr_old;
> >         unsigned                ring_size;
> > +
> > +       /**
> > +        * @max_dw:
> > +        *
> > +        * Maximum number of DWords for ring allocation. This information is
> > +        * provided at the ring initialization time, and each IP block can
> > +        * specify a specific value.
> > +        */
> >         unsigned                max_dw;
> > +
> > +       /**
> > +        * @count_dw:
> > +        *
> > +        * Count DWords: this value starts with the maximum amount of DWords
> > +        * supported by the ring. This value is updated based on the ring
> > +        * manipulation.
> > +        */
> >         int                     count_dw;
> >         uint64_t                gpu_addr;
> > +
> > +       /**
> > +        * @ptr_mask:
> > +        *
> > +        * Some IPs provide support for 64-bit pointers and others for 32-bit
> > +        * only; this behavior is component-specific and defined by the field
> > +        * support_64bit_ptr. If the IP block supports 64-bits, the mask
> > +        * 0xffffffffffffffff is set; otherwise, this value assumes buf_mask.
> > +        * Notice that this field is used to keep wptr under a valid range.
> > +        */
> >         uint64_t                ptr_mask;
> > +
> > +       /**
> > +        * @buf_mask:
> > +        *
> > +        * Buffer mask is a value used to keep wptr count under its
> > +        * thresholding. Buffer mask initialized during the ring buffer
> > +        * initialization time, and it is defined as (ring_size / 4) -1.
> > +        */
> >         uint32_t                buf_mask;
> >         u32                     idx;
> >         u32                     xcc_id;

Since we are here, what is this XCC and XCP? I guess those are focused
on datacenter GPUs, right? Also, what do those acronyms stand by?

Thanks

> > --
> > 2.49.0
> >

-- 
Rodrigo Siqueira

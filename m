Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2DC3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 20:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 423C210E054;
	Mon,  5 May 2025 20:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="d+Ux+WrC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF04110E054
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jzHIW0rHArBr4k9y3nSqbGKVVFfRHGUHeEyNWElcFIU=; b=d+Ux+WrCKi+RbZrWMzMo712a5e
 mFaNOaQXGLfFYnJGECSrrdqcQkyveIojirrOfzSKeOyoIGcbvV/vSwp/Jo39NScG7xIU/LpmMiQzX
 xxIKC4wqGuGzd6rD2Powi0QV32KbA1NCY8EamYClNaWbbmxruvauJ1TTC5Vum5ELuVzl3En/i+lVM
 qECy1sv6497iPjDSIpEnzQSJBrWGOkT7fk0Dl1cseii2qJyTQjuRdlXo1T34JjCBXlmPBlfBXg8UC
 aOpR8cUSyu3qibf2N9RstPOvpo8uDp9BOKLJY85DsDrKGVW2/rpi/LR9jK+Y3+AbCorW89Sop4n/Z
 0GzjXXEQ==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=debian.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uC2Y6-003t8a-UC; Mon, 05 May 2025 22:39:45 +0200
Date: Mon, 5 May 2025 14:39:40 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH 1/6] drm/amd/amdgpu: Add a helper to copy the CSB buffer
 into the ring buffer
Message-ID: <arkifr6nxcr6ki2ahmhhsbwi7schori2blvz62blyykk47ac6s@xj4qe44g2dar>
References: <20250504214801.406245-1-siqueira@igalia.com>
 <20250504214801.406245-2-siqueira@igalia.com>
 <b1c2d811-132a-47e5-a13f-086125b849b5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1c2d811-132a-47e5-a13f-086125b849b5@amd.com>
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

On 05/05, Christian König wrote:
> On 5/4/25 23:47, Rodrigo Siqueira wrote:
> > In the GFX code, there are multiple parsers of the CSB buffer, which can
> > be avoided. This data is parsed via get_csb_buffer() in earlier stages,
> > and the result can be checked in "adev->gfx.rlc.cs_ptr". To avoid
> > re-parser the CSB buffer, this commit introduces a helper that copies
> > the CSB buffer into the ring buffer.
> > 
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
> >  2 files changed, 25 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 8f1a2f7b03c1..dfd48670a0bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2323,6 +2323,27 @@ void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count)
> >  	buffer[count++] = cpu_to_le32(0);
> >  }
> >  
> > +/**
> > + * amdgpu_gfx_write_csb_to_ring - Write the CSB buffer into the ring
> > + *
> > + * @ring: Ring reference.
> > + * @csb_buffer: CSB buffer.
> > + * @csb_size: CSB buffer size.
> > + *
> > + * Usually, the adev->gfx.rlc.cs_ptr field is filled in earlier stages via
> > + * get_csb_buffer(). This function just gets the CSB buffer and fills it in the
> > + * ring buffer.
> > + */
> > +void amdgpu_gfx_write_csb_to_ring(struct amdgpu_ring *ring,
> 
> We already have the amdgpu_ring_write_multiple() function for exactly that.

I'll prepare a V2 that uses amdgpu_ring_write_multiple().

> 
> > +				  volatile u32 *csb_buffer,
> 
> Please drop volatile from all pointers inside the kernel and point me out if you still find some in existing code.
> 
> They are nearly always used incorrectly, see here https://docs.kernel.org/process/volatile-considered-harmful.html

Thanks for the link. I'll make a separate patchset for that.

Thanks
Siqueira

> 
> Thanks,
> Christian.
> 
> 
> > +				  u32 csb_size)
> 
> 
> 
> 
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < csb_size; i++)
> > +		amdgpu_ring_write(ring, csb_buffer[i]);
> > +}
> > +
> >  /*
> >   * debugfs for to enable/disable gfx job submission to specific core.
> >   */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 08f268dab8f5..ce684c3d3d89 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -646,6 +646,10 @@ u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer);
> >  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count);
> >  void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count);
> >  
> > +void amdgpu_gfx_write_csb_to_ring(struct amdgpu_ring *ring,
> > +				  volatile u32 *csb_buffer,
> > +				  u32 csb_size);
> > +
> >  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> >  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
> >  
> 

-- 
Rodrigo Siqueira

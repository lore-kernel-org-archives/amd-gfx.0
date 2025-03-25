Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D036C36005
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 22:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BD710E611;
	Tue, 25 Mar 2025 22:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="et2nq5j3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D940B10E611
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P9V00MsPsemQ816XwV/cald/T7vAUz5cQc4nO+FTO94=; b=et2nq5j3SFYR3t4EeyPuNS7woG
 587VlqiCMVwm6BYNhIcxf7Yb+MV1osgVARrxKqNlYwWAL8fGE6mp0rnkmR72P/5K4BDAl+uSoIP2P
 Y+gj+cW+LswuQqNIMem9KCJ4DPp6UC6AUkJ4GE6XYnKY9wNLpH0kSlsiZxXzwaqCehsNxV9Bvdcvu
 xRDiApPeS/sHnvDGHcdyqQC//7mIa2fopDzyOIAvGPDVMNMPXv6oTyP53kGelHtusAeSC1gZa8YpA
 JM4y9LBmGvAXpJV4/ufQHH6CE0MWL7peBa2I575l/ZpHjZ964/IoZ5y1bBnMsUSErZgkoV78WZYRp
 lagQFncA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1txDCx-006LgT-UL; Tue, 25 Mar 2025 23:57:20 +0100
Date: Tue, 25 Mar 2025 16:57:16 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx6: fix CSIB handling
Message-ID: <3pbq5numudcee6upgouzlaltdmo346pgb54bvzvefjcn2rf6ja@tayk46gtxcls>
References: <20250319162225.3775315-1-alexander.deucher@amd.com>
 <qb3g5stqctrdwfqwbrlwzuevcuxvof4z3yj2iigfuv4mrzpbc2@ubfz5xidet53>
 <CADnq5_Ns=MMiO=VvWpT9Gr6Kb5grqXA5TR_omYB411m=K2y-SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Ns=MMiO=VvWpT9Gr6Kb5grqXA5TR_omYB411m=K2y-SQ@mail.gmail.com>
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

On 03/25, Alex Deucher wrote:
> On Tue, Mar 25, 2025 at 4:16 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > On 03/19, Alex Deucher wrote:
> > > We shouldn't return after the last section.
> > > We need to update the rest of the CSIB.
> >
> > What is CSIB?
> 
> Clear State Indirect Buffer.  It provides the clear state that gets
> put into the hardware context if when user mode puts requests the
> clear state in their command buffer.  Driver programs this explicitly
> when it sets up the kernel rings.  Driver also provides a pointer to
> it which is used by the firmware to load the clear state in some
> cases.
>

Thanks for the explanation.
 
> >
> > What happens if the other CSIB is not updated?
> 
> The clear state packet submitted by userspace won't work as expected
> if the clear state is not properly initialized.  In this case, I'm not
> sure if there is actually a function difference since the driver
> always initializes the clear state at kernel queue init time, but best
> to make sure the buffer pointed to by the RLC is correct.
>

Make sense.

This series is:

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks
 
> Alex
> 
> >
> > Thanks
> >
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > > index 13fbee46417af..cee2cf47112c9 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > > @@ -2874,8 +2874,6 @@ static void gfx_v6_0_get_csb_buffer(struct amdgpu_device *adev,
> > >                               buffer[count++] = cpu_to_le32(ext->reg_index - 0xa000);
> > >                               for (i = 0; i < ext->reg_count; i++)
> > >                                       buffer[count++] = cpu_to_le32(ext->extent[i]);
> > > -                     } else {
> > > -                             return;
> > >                       }
> > >               }
> > >       }
> > > --
> > > 2.48.1
> > >
> >
> > --
> > Rodrigo Siqueira

-- 
Rodrigo Siqueira

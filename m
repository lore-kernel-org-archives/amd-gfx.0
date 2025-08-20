Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A6CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 22:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC65C10E800;
	Wed, 20 Aug 2025 22:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kZ4c39JH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AB610E800
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 22:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fUM4RnEphfrta/gFGKZi9OvvRFfbGfuWGKM/K8w8hYk=; b=kZ4c39JH4r1m8eAKklgDC/pX3u
 w2gn5SL05x19S1AIrgIaTTmesRpZHbWHLCojn6FFK9DQCGzkUpca6ZT5RxStLLZiLunRotKbUcbR1
 RyuEY9oVzfNF4XHoXdys8xAk5ZzflaCvKpvramCVWpxKC7QOAZkn2WrRPFsVEkkd+YfHkQ8cs8CLN
 B/tFdp7YyOAFYEDtZY7aA21umfTC0hXqyKGa97cAK6RzXnCbB+4m6YO+WuEylwdGNPHeC4cgLSQ1D
 qZTHJxeNtbYp274kDA9hcR0nRoLsOBs6g2hunmzzn9AXzbVzlbZ/eJbjzTmYQNM/OmA/bdxgTN6dO
 sZGLWVcw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uor04-00Gy46-MT; Thu, 21 Aug 2025 00:09:45 +0200
Date: Wed, 20 Aug 2025 16:09:39 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 1/3] drm/amdgpu/vcn: Use the correct irq for the ring
 initialization
Message-ID: <wxag4tn4ruescninedpkjgezfh73yoas4jribjiom35wpby2ez@tkwr6qmbq6qx>
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-2-siqueira@igalia.com>
 <CADnq5_OqL2PnQQBY+1UQy26AhH0yG5PGsKDVv7zY1+fZqha89w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OqL2PnQQBY+1UQy26AhH0yG5PGsKDVv7zY1+fZqha89w@mail.gmail.com>
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

On 08/18, Alex Deucher wrote:
> On Sat, Aug 16, 2025 at 12:28 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > In the loop that iterates over the different VCN instances from VCN
> > 4.0.3, the same irq source has been passed for different instances.
> > This commit addresses the issue by adding the missing index to the array
> > access for the IRQ.
> 
> This is on purpose.  There are no per instance source ids on 4.0.3.
> The IH packets on this chip have a separate field to differentiate the
> instances.

Thanks for the explanation. Is this rationale also valid for VCN 1.0 and
VCN 2.0?

Also, do you think it is worth making this hardware difference more
evident in the code with something like this:

-               r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
+
+               // There are no per-instance source IDs on 4.0.3, the IH
+               // packets use a separate field to differentiate instances.
+               r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[0].irq, 0,

Thanks

> 
> Alex
> 
> >
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > index a63a1e3435ab..018a526a8801 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -212,7 +212,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
> >
> >                 ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
> >                 sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
> > -               r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> > +               r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> >                                      AMDGPU_RING_PRIO_DEFAULT,
> >                                      &adev->vcn.inst[i].sched_score);
> >                 if (r)
> > --
> > 2.47.2
> >

-- 
Rodrigo Siqueira

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF3BCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 22:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305C110E802;
	Wed, 20 Aug 2025 22:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="f2OqTOfu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF4A10E802
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 22:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+DZJ7bXiBzd9sxVkQZum1sBGJfEfaC+ZgrvkRCzsYss=; b=f2OqTOfu8OrF0ERZkeJL1RoCC+
 ImX+YWbNFwBnxvoGrh0Pf2lJtwuKyI2cdvQjQjUMPf+5jLn3CnH6zKg4NCB79XX2YfSMd+2dUUs5J
 fF+yb6sBakYD+pZJ79fp6CA/yKSehRTJZIfAq6eEX4eGV6Xb6ui1UdShd3G5FhlmC56cRVjc7sPFI
 WNSvUWGg930rSlfkMykYoFSB5bXsNgzCWO4+cpwBQQ+bA5OtxaOf4CkhOExF8muKXPy2V1GkgLpRM
 EnLb1CVtueoIWSIQffyTxEqAvfRwwTQE+AQUu1NIgG0HiAzDT7KCc32xpiwWYaXNc/IACKLnkKjqz
 aiiwUQ8w==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uor1G-00Gy6b-NX; Thu, 21 Aug 2025 00:10:59 +0200
Date: Wed, 20 Aug 2025 16:10:54 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 3/3] drm/amdgpu/vcn: Ensure that sysfs reset run in the
 fini
Message-ID: <yj5khhsrqzirxlvvmiilxn7zvqfmu7hiw2ymfiiovjksqnjlkv@3itkezhiac4e>
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-4-siqueira@igalia.com>
 <CADnq5_NjHx0te+umOUo=t5c-79yjDVrRQjkFiLsAX6RppepSEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NjHx0te+umOUo=t5c-79yjDVrRQjkFiLsAX6RppepSEA@mail.gmail.com>
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
> > The function amdgpu_vcn_sysfs_reset_mask_fini() in the
> > vcn_v5_0_1_sw_fini() is invoked at the end of the function, after
> > amdgpu_vcn_sw_fini(). This can be a problem if amdgpu_vcn_sw_fini()
> > returns early, since the VCN reset sysfs interface will not be removed.
> > This commit addresses the issue by moving
> > amdgpu_vcn_sysfs_reset_mask_fini() above amdgpu_vcn_sw_fini(), aligning
> > the fini code with vcn_v4_0_3_sw_fini().
> >
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > index 7cb21e2b4eb0..3b7372861032 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > @@ -245,14 +245,14 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
> >                         return r;
> >         }
> >
> > +       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> > +
> >         for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> >                 r = amdgpu_vcn_sw_fini(adev, i);
> 
> This function always returns success.  I'd suggested changing it to a
> void and dropping the early return.

I'll do that in the V2.

Thanks

> 
> Alex
> 
> >                 if (r)
> >                         return r;
> >         }
> >
> > -       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.47.2
> >

-- 
Rodrigo Siqueira

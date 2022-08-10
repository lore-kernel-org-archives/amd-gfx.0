Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7094C25B07
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 15:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B19011AAC6;
	Wed, 10 Aug 2022 15:40:11 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9793F18AEFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 15:38:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 09F9360ED3;
 Wed, 10 Aug 2022 15:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796BFC433C1;
 Wed, 10 Aug 2022 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1660145898;
 bh=kR+fXsKAxABIT1HKS0zsO7tkAj9hgofrEX2EKzA30wM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PmfyGLY/LThm40Coer3DBqadas4GrDRpac7YJaLg2NiMC2TxHYXEBYIR4y97OdBdG
 +EpeeZfEdCIv6kt6C529IJfPQN4yumY/bCsmHy0mAatM/9YVUulkmmsPOCTuWD3y5H
 hOiOgZutafM6u4JwqxiL581dOXEdJfhhnYAr97tk=
Date: Wed, 10 Aug 2022 17:38:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in fbdev init
Message-ID: <YvPQ6MBF6V5FUEHF@kroah.com>
References: <20220719185659.2068735-1-alexander.deucher@amd.com>
 <CADnq5_MkB8xKHZxVsiXfWPA-QuVrrNCNXF=ScrYAPjNbAH36LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MkB8xKHZxVsiXfWPA-QuVrrNCNXF=ScrYAPjNbAH36LA@mail.gmail.com>
X-Mailman-Approved-At: Wed, 10 Aug 2022 15:40:00 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 hgoffin@amazon.com, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 10, 2022 at 11:28:18AM -0400, Alex Deucher wrote:
> On Tue, Jul 19, 2022 at 2:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
> >
> > The new vkms virtual display code is atomic so there is
> > no need to call drm_helper_disable_unused_functions()
> > when it is enabled.  Doing so can result in a segfault.
> > When the driver switched from the old virtual display code
> > to the new atomic virtual display code, it was missed that
> > we enable virtual display unconditionally under SR-IOV
> > so the checks here missed that case.  Add the missing
> > check for SR-IOV.
> >
> > There is no equivalent of this patch for Linus' tree
> > because the relevant code no longer exists.  This patch
> > is only relevant to kernels 5.15 and 5.16.
> >
> > Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org # 5.15.x
> > Cc: hgoffin@amazon.com
> 
> Hi Greg,
> 
> Is there any chance this can get applied?  It fixes a regression on
> 5.15 and 5.16.

Ah, missed this as it was not obvious that this was a not-upstream
commit at all, sorry.

I'll dig it out of lore.kernel.org and queue it up for the next round of
releases, but note, this is our "busy time" with many patches marked for
stable.

Oh and 5.16 is long end-of-life, nothing anyone can do there, and no one
should be using that kernel version anymore, so no issues there.

thanks,

greg k-h

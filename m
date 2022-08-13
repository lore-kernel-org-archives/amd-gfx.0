Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B92C19F2D
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 20:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D49D72A22C;
	Sat, 13 Aug 2022 20:10:38 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542F7934C8
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 12:56:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1E0D6B80159;
 Sat, 13 Aug 2022 12:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B4C433D6;
 Sat, 13 Aug 2022 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1660395357;
 bh=jvqn0fx244qzYOS4iDFSsnziEQCpWTTwSxEuG/P5ctA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rlmehEoE9xF7f8y+2RsnNaDFwIWvIF362w4qz3z+r1Rb5nPZKewRSkBm6puW+F5NU
 6pdVYBV9+7RdMoSBcn0MOwNFotreYGu7vo+wjPXcVITsX9Mc33RmgcIZ44hNZuO6n0
 yWW2AjkfPzO9lYAfVVChIAG+1nU2R+utcqqMwkWw=
Date: Sat, 13 Aug 2022 14:55:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix check in fbdev init
Message-ID: <YvefW7SSPvTVr07y@kroah.com>
References: <20220719185659.2068735-1-alexander.deucher@amd.com>
 <CADnq5_MkB8xKHZxVsiXfWPA-QuVrrNCNXF=ScrYAPjNbAH36LA@mail.gmail.com>
 <YvPQ6MBF6V5FUEHF@kroah.com>
 <CADnq5_OtXNALuQwsp-yShKxsyZTnfhheSuf9UqfRkbtm9GddiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OtXNALuQwsp-yShKxsyZTnfhheSuf9UqfRkbtm9GddiA@mail.gmail.com>
X-Mailman-Approved-At: Sat, 13 Aug 2022 20:10:15 +0000
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

On Wed, Aug 10, 2022 at 11:39:39AM -0400, Alex Deucher wrote:
> On Wed, Aug 10, 2022 at 11:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 10, 2022 at 11:28:18AM -0400, Alex Deucher wrote:
> > > On Tue, Jul 19, 2022 at 2:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
> > > >
> > > > The new vkms virtual display code is atomic so there is
> > > > no need to call drm_helper_disable_unused_functions()
> > > > when it is enabled.  Doing so can result in a segfault.
> > > > When the driver switched from the old virtual display code
> > > > to the new atomic virtual display code, it was missed that
> > > > we enable virtual display unconditionally under SR-IOV
> > > > so the checks here missed that case.  Add the missing
> > > > check for SR-IOV.
> > > >
> > > > There is no equivalent of this patch for Linus' tree
> > > > because the relevant code no longer exists.  This patch
> > > > is only relevant to kernels 5.15 and 5.16.
> > > >
> > > > Fixes: 84ec374bd580 ("drm/amdgpu: create amdgpu_vkms (v4)")
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: stable@vger.kernel.org # 5.15.x
> > > > Cc: hgoffin@amazon.com
> > >
> > > Hi Greg,
> > >
> > > Is there any chance this can get applied?  It fixes a regression on
> > > 5.15 and 5.16.
> >
> > Ah, missed this as it was not obvious that this was a not-upstream
> > commit at all, sorry.
> >
> > I'll dig it out of lore.kernel.org and queue it up for the next round of
> > releases, but note, this is our "busy time" with many patches marked for
> > stable.
> >
> > Oh and 5.16 is long end-of-life, nothing anyone can do there, and no one
> > should be using that kernel version anymore, so no issues there.
> 
> Thanks Greg.  Much appreciated.

Sorry for the delay, now queued up.

greg k-h

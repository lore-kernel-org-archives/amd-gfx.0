Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A691AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 18:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD9F10EA0B;
	Mon,  9 May 2022 18:18:04 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20FE10EA05;
 Mon,  9 May 2022 16:20:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3EDB4B816FC;
 Mon,  9 May 2022 16:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D4C385AE;
 Mon,  9 May 2022 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652113236;
 bh=LllHEgeoLTDOhwjbyHwW62k63J60brWNA8omZ65KYPw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NGrLarIgffZmyEkx7ZqPpEltf6OICGEr/amlNnfhr/r+YMlNMwbS01qrxK5zx4p7R
 qPbQwZnmSFsgpmWgf0VN1UvPpadiJmbK1Ai8O3KxuNoZh7wEiOcGQAkZEICLyX2Ycd
 8gsSvSiBBgvbs/xksA5PJiIvs1Nt+J26caz3/lwI=
Date: Mon, 9 May 2022 18:20:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5.10 1/1] drm/amdgpu: Ensure the AMDGPU file descriptor
 is legitimate
Message-ID: <Ynk/SsWQKh/dmgQ3@kroah.com>
References: <20220412152057.1170235-1-lee.jones@linaro.org>
 <Ylf5zmP88Lw0md47@kroah.com> <Ynkp3+eBhhilI8vK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ynkp3+eBhhilI8vK@google.com>
X-Mailman-Approved-At: Mon, 09 May 2022 18:18:03 +0000
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
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Felix Kuehling <Felix.Kuehling@amd.com>, stable@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 09, 2022 at 03:49:03PM +0100, Lee Jones wrote:
> On Thu, 14 Apr 2022, Greg KH wrote:
> 
> > On Tue, Apr 12, 2022 at 04:20:57PM +0100, Lee Jones wrote:
> > > [ Upstream commit b40a6ab2cf9213923bf8e821ce7fa7f6a0a26990 ]
> > > 
> > > This is a partial cherry-pick of the above upstream commit.
> > > 
> > > It ensures the file descriptor passed in by userspace is a valid one.
> > > 
> > > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: "Christian König" <christian.koenig@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > Now queued up, thanks.
> 
> Could you also back-port this into v5.4 please?
> 
> FYI, in the v5.10.y tree, it's now called:
> 
>   f0c31f192f38c drm/amdkfd: Use drm_priv to pass VM from KFD to amdgpu
> 

Now queued up, thanks.

greg k-h

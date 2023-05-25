Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA04C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 16:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAB210E109;
	Thu, 25 May 2023 16:29:17 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B4D10E109
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 16:29:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E052E60B01;
 Thu, 25 May 2023 16:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0123C433D2;
 Thu, 25 May 2023 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685032153;
 bh=QKtXScyuMsYim2gpFfOD704sOH8i/M/4NHWL1i8YMAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p8QQMP2/HfAskX9zA7pIF/eREodWgdXX8PWAFscd8DBBjG6IbHO8PZQBjvR10sAfo
 q16NhAiDZ4qLbpXLYgNQ9zfKw10rCfdgn1tNs93v/CwwarntLsnzCgnkqSOiHuCErU
 xxSWb/XLm3xWZjNWdlF3VR/F1zDtTHovQsIP6cmGYcdW2SZi7jOSXqWAk3jjfH6i00
 qPtBi2dH3sLt7JFkvugfggPLQc4GFX6lu3qcUIQV1s5fEMLTM9TlMwzeHFuj5fuw0r
 Dz7IeQ0ySvarN21K4NlKu9nY/dNjmRyU7DBuIOcUjXAd4A8Upmu8pdcOUuMkR8o4Da
 wv3hDMyd2chfg==
Date: Thu, 25 May 2023 09:29:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Mark mmhub_v1_8_mmea_err_status_reg as
 __maybe_unused
Message-ID: <20230525162911.GA552113@dev-arch.thelio-3990X>
References: <20230519124438.365184-1-srinivasan.shanmugam@amd.com>
 <20230525152247.GA187374@dev-arch.thelio-3990X>
 <c25b9e4b-535e-801b-12c3-8d4415c321ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c25b9e4b-535e-801b-12c3-8d4415c321ff@amd.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, llvm@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 25, 2023 at 12:26:56PM -0400, Luben Tuikov wrote:
> On 2023-05-25 11:22, Nathan Chancellor wrote:
> > On Fri, May 19, 2023 at 06:14:38PM +0530, Srinivasan Shanmugam wrote:
> >> Silencing the compiler from below compilation error:
> >>
> >> drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c:704:23: error: variable 'mmhub_v1_8_mmea_err_status_reg' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> >> static const uint32_t mmhub_v1_8_mmea_err_status_reg[] = {
> >>                       ^
> >> 1 error generated.
> >>
> >> Mark the variable as __maybe_unused to make it clear to clang that this
> >> is expected, so there is no more warning.
> >>
> >> Cc: Christian König <christian.koenig@amd.com>
> >> Cc: Lijo Lazar <lijo.lazar@amd.com>
> >> Cc: Luben Tuikov <luben.tuikov@amd.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > 
> > Traditionally, this attribute would go between the [] and =, but that is
> > a nit. Can someone please pick this up to unblock our builds on -next?
> > 
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> I'll pick this up, fix it, and submit to amd-staging-drm-next.

Thanks a lot :)

> Which -next are you referring to, Nathan?

linux-next, this warning breaks the build when -Werror is enabled, such
as with allmodconfig:

https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2QHtlCTz2JL0yXNpRB5hVmiP9lq/build.log

Cheers,
Nathan

> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> >> index 3648994724c2..cba087e529c0 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> >> @@ -701,6 +701,7 @@ static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
> >>  		mmhub_v1_8_inst_reset_ras_error_count(adev, i);
> >>  }
> >>  
> >> +__maybe_unused
> >>  static const uint32_t mmhub_v1_8_mmea_err_status_reg[] = {
> >>  	regMMEA0_ERR_STATUS,
> >>  	regMMEA1_ERR_STATUS,
> >> -- 
> >> 2.25.1
> >>
> 

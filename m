Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B93ACCD18D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C53510EA1E;
	Thu,  9 Oct 2025 12:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xa40BtJX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A061410E209
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 10:49:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 62263621D0;
 Thu,  9 Oct 2025 10:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF069C4CEF9;
 Thu,  9 Oct 2025 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1760006949;
 bh=vP9HeJi0bXQzo1u6hZI+xUyxJCXb3b/WOUuQAuCYXJ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xa40BtJX2scHkLcabOL172JePmIvhkplIlCHTz1JQ38ZcNWYbwve8S0k7bW0B60qr
 O2WnT59zxUQ3A52kHPS0T0PzR2COJ0u9/tyJj8G1DOdPS2u4RQLsLMPH4dy8sk85eI
 OQ/sWTdc1DBsKErwxWVa4MBGRfVIy4Qh0NXY97H0=
Date: Thu, 9 Oct 2025 12:49:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: harry.wentland@amd.com, Christian.Koenig@amd.com, sunpeng.li@amd.com,
 airlied@gmail.com, simona@ffwll.ch, Alexander.Deucher@amd.com,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
Message-ID: <2025100959-denture-freebie-76b4@gregkh>
References: <2025100931-retorted-mystified-bd52@gregkh>
 <F64C306E-67BC-4ADC-AF8F-1DACAF695D9D@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F64C306E-67BC-4ADC-AF8F-1DACAF695D9D@linux.dev>
X-Mailman-Approved-At: Thu, 09 Oct 2025 12:35:29 +0000
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

On Thu, Oct 09, 2025 at 12:00:29PM +0200, Matthew Schwartz wrote:
> 
> > 
> > On Oct 9, 2025, at 11:51 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > ﻿On Thu, Oct 09, 2025 at 11:23:01AM +0200, Matthew Schwartz wrote:
> >> This fix regressed the original issue that commit d83c747a1225
> >> ("drm/amd/display: Fix brightness level not retained over reboot") solved,
> >> so revert it until a different approach to solve the regression that
> >> it caused with AMD_PRIVATE_COLOR is found.
> >> 
> >> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume")
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
> >> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> >> ---
> >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
> >> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
> >> 2 files changed, 4 insertions(+), 15 deletions(-)
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> 
> Apologies, I was a bit confused by:
> 
> If a regression made it into a proper mainline release during the past twelve months, ensure to tag the fix with “Cc: stable@vger.kernel.org”
> 
> in the regressions page, but I see now the way I did it via email cc was incorrect.
> 
> Should I resend with that fixed?

Please do.

thanks!

greg k-h

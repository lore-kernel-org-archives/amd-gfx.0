Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DD1CCD187
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 12:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B9E10EA1B;
	Thu,  9 Oct 2025 12:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cxlowe+C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574FC10E201
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 09:51:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DE0AF44E33;
 Thu,  9 Oct 2025 09:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EE1C4CEE7;
 Thu,  9 Oct 2025 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1760003500;
 bh=GijdTCamNQ82KE4Uz6SV7HvRXp4xVcT6Z1OWSeBQXxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cxlowe+CbNsCH/XpnQKxXqwojpEdXJQvfGkWQOYSX+fX5n2k0pqxDg19ukJZFmFHm
 /LV6YTHAVB5DmM6JmOafsZUnWFNVAA8Q2aP0xWoet4nuJ/2LQo+H5F2lZZvPXUp/Xh
 caGuGm/111pVLrcbNCGM4vzGU0yf5uHqL6tF+dKw=
Date: Thu, 9 Oct 2025 11:51:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: harry.wentland@amd.com, christian.koenig@amd.com, sunpeng.li@amd.com,
 airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
Message-ID: <2025100931-retorted-mystified-bd52@gregkh>
References: <20251009092301.13212-1-matthew.schwartz@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009092301.13212-1-matthew.schwartz@linux.dev>
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

On Thu, Oct 09, 2025 at 11:23:01AM +0200, Matthew Schwartz wrote:
> This fix regressed the original issue that commit d83c747a1225
> ("drm/amd/display: Fix brightness level not retained over reboot") solved,
> so revert it until a different approach to solve the regression that
> it caused with AMD_PRIVATE_COLOR is found.
> 
> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
>  2 files changed, 4 insertions(+), 15 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

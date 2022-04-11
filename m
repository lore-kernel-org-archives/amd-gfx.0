Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B693C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 16:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A2F10E7BE;
	Mon, 11 Apr 2022 16:51:56 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F4A10E381
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 16:49:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E971761716;
 Mon, 11 Apr 2022 16:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFB0C385B3;
 Mon, 11 Apr 2022 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1649695796;
 bh=1jYHZDtKcZN4hrDB4/1MZ7QbbDghduGjzC4q/5suTSU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UIjXvBNM24s8ZfHTQmWtfdjigxHEagBE9m8FHFmnq7thxHn495VdI+pKP+3eNq2kJ
 V2PC/9DkVK77LpuPpUbx1Rps16NpMbDryIBkAGZmLmjUORNIPqtliBSvFjo+flWUy1
 kMLL/zownJHJfwaUfIxbnNsLBaWD3RKZRQxDlCws=
Date: Mon, 11 Apr 2022 18:49:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 5.4 0/2] Fix two instances of -Wstrict-prototypes in
 drm/amd
Message-ID: <YlRcKVjXGH/uJiqx@kroah.com>
References: <20220411164308.2491139-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411164308.2491139-1-nathan@kernel.org>
X-Mailman-Approved-At: Mon, 11 Apr 2022 16:51:54 +0000
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
Cc: Sasha Levin <sashal@kernel.org>, Felix Kuehling <Felix.Kuehling@amd.com>,
 llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 11, 2022 at 09:43:06AM -0700, Nathan Chancellor wrote:
> Hi everyone,
> 
> These two patches resolve two instances of -Wstrict-prototypes with
> newer versions of clang that are present in 5.4. The main Makefile makes
> this a hard error.
> 
> The first patch is upstream commit 63617d8b125e ("drm/amdkfd: add
> missing void argument to function kgd2kfd_init"), which showed up in
> 5.5.
> 
> The second patch has no upstream equivalent, as the code in question was
> removed in commit e392c887df97 ("drm/amdkfd: Use array to probe
> kfd2kgd_calls") upstream, which is part of a larger series that did not
> look reasonable for stable. I opted to just fix the warning in the same
> manner as the prior patch, which is less risky and accomplishes the same
> end result of no warning.
> 
> Colin Ian King (1):
>   drm/amdkfd: add missing void argument to function kgd2kfd_init
> 
> Nathan Chancellor (1):
>   drm/amdkfd: Fix -Wstrict-prototypes from
>     amdgpu_amdkfd_gfx_10_0_get_functions()
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 2845ff3fd34499603249676495c524a35e795b45
> -- 
> 2.35.1
> 

Now queued up, thanks.

greg k-h

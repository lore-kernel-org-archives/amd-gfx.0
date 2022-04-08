Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2638C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 21:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158ED10E684;
	Fri,  8 Apr 2022 21:07:58 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B39310E684
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 21:07:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFB461FAD;
 Fri,  8 Apr 2022 21:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ECDC385B1;
 Fri,  8 Apr 2022 21:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649452075;
 bh=FCxRs3y/j41wf9f7bOfro6zne0vGhTOt8Bvd99e790Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NjpAP1iTXXVZjPX04LyLBNr7W3bNPuqgvdSvT2HVc5C1n8+QmVyh/xLiX+Tha0XFs
 4+QEvyRChPX12Y58SxEto9dJh6KCM/VjTOHRYqE9EQKjDahPmnx6wuPQPmRs8MIyx0
 5jan9rZx28qdtJqhc2p+1a0EFBI7+NhnNwGoQu9j09B2ADQgG1GB2LuyJMXlK0ws7a
 PlJCLcQI11oc1JcfTRHGzL6VEetcz6dWAfCvMCp3b+7uN0D0e2gGdxcjkMBYAv/lC6
 tKPZgfB41csq0YtoCifzVwdASWgWCbnmq2cqyqmlvNtNGzX9n1pJSM7HqPA+mafl4F
 saPZOj2mlwKfw==
Date: Fri, 8 Apr 2022 14:07:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix 64 bit divide in freesync code
Message-ID: <YlCkKQE8wQ/Tmi7F@dev-arch.thelio-3990X>
References: <20220408210455.2603691-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408210455.2603691-1-alexander.deucher@amd.com>
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org,
 Angus Wang <Angus.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 08, 2022 at 05:04:55PM -0400, Alex Deucher wrote:
> Use div_u64() rather than a a 64 bit divide.
> 
> Fixes: 3fe5739db48843 ("drm/amd/display: Add flip interval workaround")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Angus Wang <Angus.Wang@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Aric Cyr <Aric.Cyr@amd.com>
> Cc: Nathan Chancellor <nathan@kernel.org>

This resolves the build failure for me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 0130f1879116..d2d76ce56f89 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -1239,7 +1239,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
>  	if (in_out_vrr->supported == false)
>  		return;
>  
> -	cur_timestamp_in_us = dm_get_timestamp(core_freesync->dc->ctx)/10;
> +	cur_timestamp_in_us = div_u64(dm_get_timestamp(core_freesync->dc->ctx), 10);
>  
>  	in_out_vrr->flip_interval.vsyncs_between_flip++;
>  	in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
> -- 
> 2.35.1
> 

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA975C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 23:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C78F10E4CD;
	Thu,  7 Apr 2022 23:31:54 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F97010E4CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 23:31:52 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4B15FB8284D;
 Thu,  7 Apr 2022 23:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DC7C385A4;
 Thu,  7 Apr 2022 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649374306;
 bh=ljQsbPZvVTeHb8EmSo5Xd2jSLdnqVwWEU449m/hptQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SVF54AwRuxspS7Rd6oX52rK0qUMZ3/bh4Z/qEP+bu72I0YvRoP9sUuBFli7DtWLbe
 MtpO0whcw7DwHUylQzqyKLaqp84/O2HRZ64uwsZtQgy1Pa2SLD6BrI026+CFxJF/1/
 0W91+9Rh6a76Gw6uC8FvZAOqGjnd3LytoBB34coAc4vz2RA7cHC0UkzgL7Zw9Zo6iX
 oJqk9cc9Bg99/gMESpi5mxhCDy9dbNaqvkG+wV1rYZnZkemrVXL6W7V+aWHWHb7zuN
 VcOg/O0vbrvHUR+Mfk5x6HaVaKbQlEBs1qODydvNHnzhF2B413UwnUqt/WtRUqC9h7
 u1/us3R1cpaLw==
Date: Thu, 7 Apr 2022 16:31:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix 64 bit divide in freesync code
Message-ID: <Yk90X7v8hIgmX5Q5@dev-arch.thelio-3990X>
References: <20220407195029.1581581-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407195029.1581581-1-alexander.deucher@amd.com>
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

On Thu, Apr 07, 2022 at 03:50:29PM -0400, Alex Deucher wrote:
> Use do_div() rather than a a 64 bit divide.
> 
> Fixes: 3fe5739db48843 ("drm/amd/display: Add flip interval workaround")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Angus Wang <Angus.Wang@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Aric Cyr <Aric.Cyr@amd.com>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 0130f1879116..70f06fa8cc2b 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -1230,6 +1230,7 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
>  {
>  	struct core_freesync *core_freesync = NULL;
>  	unsigned int cur_timestamp_in_us;
> +	unsigned long long tmp;
>  
>  	if ((mod_freesync == NULL) || (stream == NULL) || (in_out_vrr == NULL))
>  		return;
> @@ -1239,7 +1240,9 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
>  	if (in_out_vrr->supported == false)
>  		return;
>  
> -	cur_timestamp_in_us = dm_get_timestamp(core_freesync->dc->ctx)/10;
> +	tmp = dm_get_timestamp(core_freesync->dc->ctx);
> +	do_div(tmp, 10);
> +	cur_timestamp_in_us = tmp;

Any reason not to use

cur_timestamp_in_us = div_u64(dm_get_timestamp(core_freesync->dc->ctx), 10)

and save a variable?

>  	in_out_vrr->flip_interval.vsyncs_between_flip++;
>  	in_out_vrr->flip_interval.v_update_timestamp_in_us = cur_timestamp_in_us;
> -- 
> 2.35.1
> 
> 

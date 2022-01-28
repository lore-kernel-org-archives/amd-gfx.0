Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C05C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 13:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E999710E703;
	Fri, 28 Jan 2022 13:39:08 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA7010F1A2;
 Fri, 28 Jan 2022 10:17:52 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DD1F6B82513;
 Fri, 28 Jan 2022 10:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B43C340E0;
 Fri, 28 Jan 2022 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1643365069;
 bh=SHk7nsLZVBmrkzHaZ93gwIMjnBT1dr7eQOTPySNEeNY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qA460ZBgv/rmRN3I7hCrX4M19ZMSUXuy18zfqE5oMnTvRI0GSUPyb5rqr1U0g+UHc
 g8/rHG4dnuH8GTUtqoqhQxV8r6BgzXQ6Xm72g4ucdFskh+06vAY2ihaBW7gNxoQL0Z
 NAWRgT1aTxRB5pMi0e3dYfpG9tU+Nq/cLApeq2TE=
Date: Fri, 28 Jan 2022 11:17:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhou Qingyang <zhou1615@umn.edu>
Subject: Re: [PATCH] drm/amd/display/dc/calcs/dce_calcs: Fix a memleak in
 calculate_bandwidth()
Message-ID: <YfPCxX/iiDWUpWjY@kroah.com>
References: <20220124165552.56106-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124165552.56106-1-zhou1615@umn.edu>
X-Mailman-Approved-At: Fri, 28 Jan 2022 13:39:02 +0000
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
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 kjlu@umn.edu, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 25, 2022 at 12:55:51AM +0800, Zhou Qingyang wrote:
> In calculate_bandwidth(), the tag free_sclk and free_yclk are reversed,
> which could lead to a memory leak of yclk.
> 
> Fix this bug by changing the location of free_sclk and free_yclk.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 2be8989d0fc2 ("drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index ff5bb152ef49..e6ef36de0825 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -2033,10 +2033,10 @@ static void calculate_bandwidth(
>  	kfree(surface_type);
>  free_tiling_mode:
>  	kfree(tiling_mode);
> -free_yclk:
> -	kfree(yclk);
>  free_sclk:
>  	kfree(sclk);
> +free_yclk:
> +	kfree(yclk);
>  }
>  
>  /*******************************************************************************
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.


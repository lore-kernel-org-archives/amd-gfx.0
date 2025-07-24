Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90929C83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 22:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3422110E343;
	Thu, 24 Jul 2025 22:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ses+y1/A";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C70010E343
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PzJr08Kk3rYT9bzF9/O1g3428e95v75HK7x75TdFGOE=; b=Ses+y1/Auf/XKRZ0ktCKdOZ2MK
 Mh2IVbQd0O2Ust/Q2sKNzPYx0mKHqF4J250jSFbhi+RuoQh6RpRnHrQPmoO2SdZJcImuBhcq+d1fa
 8uWFxgHIrn1WpzrfwGvKpkLE7YeGamVexD3qBPF59A1R0d8JShF1TXJzrBW8sm9HAGTLvjaiCfBfa
 4lG0fOhB4k4sBLGpDj8+G98z3ojc0+kTuxofdCHOaJeC2Pf+3SAiF78Ncgvb6e6FY8bMWVhhS0b9I
 0xwAQUoZ3yk2GC2s7IqGrW4TM/icfMsh3yCZeRprs7yKT4EIPOhbMFlyvLflT76Z5QHs5zKXlDkBl
 a6pIU+cg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uf4bm-003Pbb-03; Fri, 25 Jul 2025 00:40:14 +0200
Date: Thu, 24 Jul 2025 16:40:10 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amd/display: Don't overwrite dce60_clk_mgr
Message-ID: <tyay5kxsv5fwm53gdobd2kn4l3b5y5v4ac6wv6n4lg2iefwdjw@u6gokzk4esx2>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-3-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722155830.67401-3-timur.kristof@gmail.com>
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

On 07/22, Timur Kristóf wrote:
> dc_clk_mgr_create accidentally overwrites the dce60_clk_mgr
> with the dce_clk_mgr, causing incorrect behaviour on DCE6.

Could you ellaborate on what do you mean by incorrect behaviour?

> Fix it by removing the extra dce_clk_mgr_construct.
> 
> Fixes: 62eab49faae7 ("drm/amd/display: hide VGH asic specific structs")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> index 33b9d36619ff..4071851f9e86 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> @@ -158,7 +158,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
>  			return NULL;
>  		}
>  		dce60_clk_mgr_construct(ctx, clk_mgr);
> -		dce_clk_mgr_construct(ctx, clk_mgr);

I suppose this error was not detected at the time because of the
CONFIG_DRM_AMD_DC_SI guard. This lgtm, but I guess it would be nice to
test this patch with other SI devices just to be sure

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

I added other display folks.

Thanks

>  		return &clk_mgr->base;
>  	}
>  #endif
> -- 
> 2.50.1
> 

-- 
Rodrigo Siqueira
